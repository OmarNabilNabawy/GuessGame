import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/core/helper/show_snack_bar.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/game_text_field.dart';

class TextFieldStreamBuilder extends StatelessWidget {
  const TextFieldStreamBuilder({
    super.key,
    required this.collectionName,
    required this.textEditingController,
    required this.email,
    required this.messages,
  });

  final String collectionName;
  final TextEditingController textEditingController;
  final String? email;
  final CollectionReference<Object?> messages;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy('creationTime', descending: true)
            .limit(1) // Only get the last document
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String lastGocEmail = snapshot.data!.docs.first.get('id');
            return GameTextField(
              textEditingController: textEditingController,
              isLastRoundForMe: lastGocEmail != email,
              onSubmitted: (inputValue) {
                final RegExp regExp = RegExp(r'^[0-9]+$');
                if (textEditingController.text.length == 4 &&
                    regExp.hasMatch(textEditingController.text)) {
                  messages.add(
                    {
                      'id': email,
                      'roundNumbers': inputValue,
                      'isFirst': 'false',
                      kCreatedAt: DateTime.now(),
                    },
                  );
                  textEditingController.clear();
                } else {
                  showSnackBar(context, 'Input Must Contain Four Numbers');
                }
              },
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
