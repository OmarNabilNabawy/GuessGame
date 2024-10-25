import 'package:flutter/material.dart';
import 'package:guess/constants.dart';

class ItemNumber extends StatelessWidget {
  final String num;
  const ItemNumber({super.key, required this.num});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          num,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}