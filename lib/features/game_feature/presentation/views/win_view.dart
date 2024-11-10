import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/features/game_feature/data/models/winner_page_data_model.dart';
import 'package:guess/features/game_feature/presentation/manager/provider/game_state.dart';
import 'package:provider/provider.dart';

class WinView extends StatelessWidget {
  const WinView({super.key});

  @override
  Widget build(BuildContext context) {
    final WinnerPageDataModel winnerData =
        ModalRoute.of(context)?.settings.arguments as WinnerPageDataModel;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              winnerData.winnerMessage,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                handleRoomEnd(winnerData.collectionName);
                context
                    .read<GameState>()
                    .updateScore(winnerData.isMe, winnerData.collectionName);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
              child: const Text(
                'Play Again',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton(
              onPressed: () {
                handleRoomEnd(winnerData.collectionName, isFinalEnd: true);
                resetTheScore(context, winnerData);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
              child: const Text(
                'End The Game',
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }

  

  Future<void> handleRoomEnd(String collectionName,
      {bool isFinalEnd = false}) async {
    CollectionReference message =
        FirebaseFirestore.instance.collection(collectionName);

    // Check if there are any closed rooms
    QuerySnapshot closedRooms =
        await message.where('roomStatus', isEqualTo: 'closed').get();
    bool hasClosedRoom = closedRooms.docs.isNotEmpty;

    if (hasClosedRoom) {
      if (isFinalEnd) {
        // Delete all documents in the collection if it's the final end
        message.get().then((value) {
          for (DocumentSnapshot docName in value.docs) {
            docName.reference.delete();
          }
        });
      } else {
        // Delete only specific documents if it's a trial end
        message.get().then((value) {
          for (DocumentSnapshot docName in value.docs) {
            if (docName.id != collectionName) {
              docName.reference.delete();
            }
          }
        });
      }

      // Reset the room status for the main document
      await message.doc(collectionName).set({
        'roomStatus': 'waiting',
      });
    }
  }

  void resetTheScore(BuildContext context, WinnerPageDataModel winnerData) {
    final gameState = context.read<GameState>();
    final roomScores = gameState.scoringList.firstWhere(
      (room) => room.roomName == winnerData.collectionName,
    );
    roomScores.myScore = 0;
    roomScores.myFriendScore = 0;
  }

  // Future<void> deleteRoomIfGameEnd(String collectionName) async {
  //   CollectionReference message =
  //       FirebaseFirestore.instance.collection(collectionName);
  //   QuerySnapshot closedRooms =
  //       await message.where('roomStatus', isEqualTo: 'closed').get();

  //   bool hasClosedRoom = closedRooms.docs.isNotEmpty;

  //   if (hasClosedRoom) {
  //     message.get().then((value) {
  //       for (DocumentSnapshot docName in value.docs) {
  //         if (docName.id != collectionName) {
  //           docName.reference.delete();
  //         }
  //       }
  //     });
  //     message.doc(collectionName).set({
  //       'roomStatus': 'waiting',
  //     });
  //   }
  // }

  // Future<void> EndTheGame(String collectionName) async {
  //   CollectionReference message =
  //       FirebaseFirestore.instance.collection(collectionName);
  //   QuerySnapshot closedRooms =
  //       await message.where('roomStatus', isEqualTo: 'closed').get();

  //   bool hasClosedRoom = closedRooms.docs.isNotEmpty;

  //   if (hasClosedRoom) {
  //     message.get().then((value) {
  //       for (DocumentSnapshot docName in value.docs) {
  //         docName.reference.delete();
  //       }
  //     });
  //     message.doc(collectionName).set({
  //       'roomStatus': 'waiting',
  //     });
  //   }
  // }
}
