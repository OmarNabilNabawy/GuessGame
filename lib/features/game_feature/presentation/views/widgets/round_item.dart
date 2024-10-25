import 'package:flutter/material.dart';
import 'package:guess/features/game_feature/data/models/round_numbers_model.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/item_number.dart';

class RoundItem extends StatelessWidget {
  final RoundNumberModel roundNumberModel;
  const RoundItem({super.key, required this.roundNumberModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          roundNumberModel.numOfMatches,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          width: 3,
        ),
        const Icon(Icons.arrow_back),
        ItemNumber(num: roundNumberModel.firstNumber),
        ItemNumber(num: roundNumberModel.secondNumber),
        ItemNumber(num: roundNumberModel.thirdNumber),
        ItemNumber(num: roundNumberModel.forthNumber),
      ],
    );
  }
}