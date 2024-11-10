import 'package:flutter/material.dart';
import 'package:guess/features/game_feature/data/models/scoring_model.dart';
import 'package:guess/features/game_feature/presentation/manager/provider/game_state.dart';
import 'package:provider/provider.dart';

class ScoringAppBar extends StatelessWidget {
  const ScoringAppBar({
    super.key,
    required this.roomName,
  });
  final String roomName;
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, score, child) {
        final roomScore = score.scoringList
            .firstWhere((roomsNames) => roomsNames.roomName == roomName);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${roomScore.myFriendScore}'),
              const Text('Score'),
              Text('${roomScore.myScore}'),
            ],
          ),
        );
      },
    );
  }
}
