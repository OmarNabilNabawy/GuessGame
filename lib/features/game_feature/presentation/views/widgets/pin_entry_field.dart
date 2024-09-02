// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinEntryField extends StatefulWidget {
  final Function(String) onCompleted;
  const PinEntryField({
    super.key,
    required this.onCompleted,
  });

  @override
  State<PinEntryField> createState() => _PinEntryFieldState();
}

class _PinEntryFieldState extends State<PinEntryField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4, // Length of the PIN
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 20),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      onCompleted: (inputValue) {
        widget.onCompleted(inputValue);
        log("Completed: $inputValue");
      },
      // onChanged: (value) {
      //   log(value);
      // },
    );
  }
}
