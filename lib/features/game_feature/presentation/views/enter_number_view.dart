import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/core/widgets/custom_button.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/pin_entry_field.dart';

class EnterNumberView extends StatefulWidget {
  const EnterNumberView({super.key});

  @override
  State<EnterNumberView> createState() => _EnterNumberViewState();
}

class _EnterNumberViewState extends State<EnterNumberView> {
  late String value;
  String? email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    final String collectionName =
        ModalRoute.of(context)?.settings.arguments as String;
    CollectionReference messages =
        FirebaseFirestore.instance.collection(collectionName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Four Numbers'),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PinEntryField(
                onCompleted: (inputValue) => value = inputValue,
              ),
              CustomButon(
                onTap: () {
                  handleRoomStatus(collectionName, messages);
                },
                text: 'Start',
                backgroundColor: kPrimaryColor,
                textSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleRoomStatus(
      String collectionName, CollectionReference messages) async {
    QuerySnapshot querySnapshot =
        await messages.where('roomStatus', whereIn: ['closed', 'open']).get();

    bool hasClosedRoom =
        querySnapshot.docs.any((doc) => doc['roomStatus'] == 'closed');
    bool hasOpenRoom =
        querySnapshot.docs.any((doc) => doc['roomStatus'] == 'open');
    if (hasClosedRoom) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, roomsFullViewRoute,
          arguments: collectionName);
    } else if (hasOpenRoom) {
      addFirstNumber(messages);
      messages.doc(collectionName).update({
        'id': email,
        'isFirst': "other",
        'roomStatus': 'closed',
      });
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, gameViewRoute,
          arguments: collectionName);
    } else {
      addFirstNumber(messages);
      messages.doc(collectionName).set({
        'id': email,
        'isFirst': "other",
        'roomStatus': 'open',
      });
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, gameViewRoute,
          arguments: collectionName);
    }
  }

  void addFirstNumber(CollectionReference<Object?> messages) {
    messages.add(
      {
        'id': email,
        'roundNumbers': value,
        'isFirst': 'true',
        kCreatedAt: DateTime.now(),
      },
    );
  }
}
