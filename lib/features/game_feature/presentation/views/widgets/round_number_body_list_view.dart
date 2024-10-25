// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:guess/constants.dart';
// import 'package:guess/features/game_feature/data/models/round_numbers_model.dart';
// import 'package:guess/features/game_feature/presentation/views/widgets/round_item.dart';

// class RoundNumberBodyListView extends StatelessWidget {
//   const RoundNumberBodyListView(
//       {super.key,
//       required this.collectionName,
//       required this.email,
//       required this.roundValue,
//       required this.isMe});
//   final String collectionName;
//   final String? email;
//   final String? roundValue;
//   final bool isMe;

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference messages =
//         FirebaseFirestore.instance.collection(collectionName);
//     return StreamBuilder<QuerySnapshot>(
//         stream: messages.orderBy(kCreatedAt, descending: false).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<String> roundNumberList = [];
//             if (isMe) {
//               roundNumberList.addAll(snapshot.data!.docs
//                   .map((doc) {
//                     if (doc.get('id') == email &&
//                         doc.get('isFirst') == "false") {
//                       return doc.get('roundNumbers') as String?;
//                     }
//                     return null;
//                   })
//                   .where((element) => element != null)
//                   .cast<String>()
//                   .toList());
//             } else {
//               roundNumberList.addAll(snapshot.data!.docs
//                   .map((doc) {
//                     if (doc.get('id') != email &&
//                         doc.get('isFirst') == "false") {
//                       return doc.get('roundNumbers') as String?;
//                     }
//                     return null;
//                   })
//                   .where((element) => element != null)
//                   .cast<String>()
//                   .toList());
//             }
//             return ListView.builder(
//               itemCount: roundNumberList.length,
//               itemBuilder: (context, index) {
//                 int numberOfMatches = 0;
//                 for (int i = 0; i < 4; i++) {
//                   if (roundNumberList[index][i] == roundValue![i]) {
//                     numberOfMatches++;
//                   }
//                   if (numberOfMatches == 4) {
//                     Future.microtask(() {
//                       Navigator.pushNamed(context, winViewRoute,
//                           arguments: email);
//                     });
//                   }
//                 }
//                 return RoundItem(
//                   roundNumberModel: RoundNumberModel(
//                       firstNumber: roundNumberList[index][0],
//                       secondNumber: roundNumberList[index][1],
//                       thirdNumber: roundNumberList[index][2],
//                       forthNumber: roundNumberList[index][3],
//                       numOfMatches: numberOfMatches.toString()),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: SizedBox());
//           }
//         });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/features/game_feature/data/models/round_numbers_model.dart';
import 'package:guess/features/game_feature/data/models/winner_page_data_model.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/round_item.dart';

class RoundNumberBodyListView extends StatelessWidget {
  const RoundNumberBodyListView({
    super.key,
    required this.collectionName,
    required this.email,
    required this.roundValue,
    required this.isMe,
  });

  final String collectionName;
  final String? email;
  final String? roundValue;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(collectionName);
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: false).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<String> roundNumberList = _getRoundNumberList(snapshot.data!.docs);

        return ListView.builder(
          itemCount: roundNumberList.length,
          itemBuilder: (context, index) {
            int numberOfMatches =
                _calculateNumberOfMatches(roundNumberList[index]);
            if (numberOfMatches == 4) {
              _handleWin(context);
            }

            return RoundItem(
              roundNumberModel: RoundNumberModel(
                firstNumber: roundNumberList[index][0],
                secondNumber: roundNumberList[index][1],
                thirdNumber: roundNumberList[index][2],
                forthNumber: roundNumberList[index][3],
                numOfMatches: numberOfMatches.toString(),
              ),
            );
          },
        );
      },
    );
  }

  List<String> _getRoundNumberList(List<QueryDocumentSnapshot> docs) {
    return docs
        .where((doc) => _isRelevantDocument(doc))
        .map((doc) => doc.get('roundNumbers') as String)
        .toList();
  }

  bool _isRelevantDocument(QueryDocumentSnapshot doc) {
    final String docEmail = doc.get('id');
    final bool isFirst = doc.get('isFirst') == "false";

    if (isMe) {
      return docEmail == email && isFirst;
    } else {
      return docEmail != email && isFirst;
    }
  }

  int _calculateNumberOfMatches(String roundNumbers) {
    int numberOfMatches = 0;
    for (int i = 0; i < 4; i++) {
      if (roundNumbers[i] == roundValue?[i]) {
        numberOfMatches++;
      }
    }
    return numberOfMatches;
  }

  void _handleWin(BuildContext context) {
    Future.microtask(() {
      final String winnerMessage = isMe ? "You Win" : "Your Friend Wins";
      Navigator.pushReplacementNamed(
        context,
        winViewRoute,
        arguments: WinnerPageDataModel(
          winnerMessage: winnerMessage,
          collectionName: collectionName,
        ),
      );
    });
  }
}
