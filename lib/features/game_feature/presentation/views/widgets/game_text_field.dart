import 'package:flutter/material.dart';
import 'package:guess/constants.dart';

class GameTextField extends StatelessWidget {
  final void Function(String)? onSubmitted;
  final TextEditingController textEditingController;
  const GameTextField({
    super.key,
    this.onSubmitted, required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      
      maxLength: 4,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Enter Four Numbers',
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 3,
          ),
        ),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
