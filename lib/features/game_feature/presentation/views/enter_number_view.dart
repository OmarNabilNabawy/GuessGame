import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    CollectionReference messages =
        FirebaseFirestore.instance.collection(kMessagesCollections);
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
                  messages.add(
                        {
                          'id': email,
                          'roundNumbers': value,
                          'isFirst': 'true',
                          kCreatedAt: DateTime.now(),
                          
                        },
                      );
                  Navigator.pushNamed(context, gameViewRoute,
                      arguments: email);
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
}
