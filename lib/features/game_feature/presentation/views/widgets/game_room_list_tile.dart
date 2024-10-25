import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';

class GameRoomListTile extends StatelessWidget {
  const GameRoomListTile({
    super.key,
    required this.collectionName,
    this.onPressedDelete,
  });
  final String collectionName;
  final void Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleNavigation(context, collectionName);
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        color: Colors.grey[300],
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: 5, left: 15),
          leading: const Icon(Icons.place),
          title: Center(
            child: Text(
              collectionName,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          trailing: IconButton(
            onPressed: onPressedDelete,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }

  Future<bool> _doesDocumentWithEmailExist(
      CollectionReference messages, String email) async {
    QuerySnapshot querySnapshot =
        await messages.where('id', isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }

// Function to handle navigation based on the existence of the document
  Future<void> _handleNavigation(
      BuildContext context, String collectionName) async {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(collectionName);
    String? email = FirebaseAuth.instance.currentUser?.email;

    // Check if a document with the user's email exists
    bool documentExists = await _doesDocumentWithEmailExist(messages, email!);

    // Navigate to the appropriate view
    if (documentExists) {
      Navigator.of(context).pushNamed(gameViewRoute, arguments: collectionName);
    } else {
      Navigator.of(context)
          .pushNamed(enterNumberViewRoute, arguments: collectionName);
    }
  }
}
