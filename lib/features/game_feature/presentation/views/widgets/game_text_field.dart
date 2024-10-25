// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:guess/constants.dart';

class GameTextField extends StatelessWidget {
  final void Function(String)? onSubmitted;
  final TextEditingController textEditingController;
  final bool isLastRoundForMe;
  const GameTextField({
    super.key,
    this.onSubmitted,
    required this.textEditingController,
    required this.isLastRoundForMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: textEditingController,
        enabled: isLastRoundForMe,
        maxLength: 4,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: isLastRoundForMe ? 'Enter Four Numbers' : '   Wating...',
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 3,
            ),
          ),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
