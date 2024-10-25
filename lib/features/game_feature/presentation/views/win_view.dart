import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/features/game_feature/data/models/winner_page_data_model.dart';

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
                deleteRoomIfGameEnd(winnerData.collectionName);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
              child: const Text(
                'Play Again',
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteRoomIfGameEnd(String collectionName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where('roomStatus', isEqualTo: 'closed')
        .get();

    bool hasClosedRoom = querySnapshot.docs.isNotEmpty;

    if (hasClosedRoom) {
      FirebaseFirestore.instance.collection(collectionName).get().then((value) {
        for (DocumentSnapshot docName in value.docs) {
          docName.reference.delete();
        }
      });
    }
  }
}
