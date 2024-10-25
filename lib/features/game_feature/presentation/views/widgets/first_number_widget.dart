import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guess/features/game_feature/presentation/manager/provider/game_state.dart';
import 'package:provider/provider.dart';

class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({
    super.key,
    required this.collectionName,
    required this.email,
    required this.isMe,
  });
  final String collectionName;
  final String? email;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection(collectionName).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            String? roundNumber;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Wating...',
                style: TextStyle(fontSize: 28),
              );
            }
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              if (isMe) {
                roundNumber = snapshot.data!.docs.map((doc) {
                  if (doc.get('id') == email && doc.get('isFirst') == "true") {
                    return doc.get('roundNumbers') as String?;
                  }
                }).firstWhere((element) => element != null, orElse: () => null);
                if (roundNumber != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // Ensure this runs after the current frame has been built
                    context.read<GameState>().updateMyValue(roundNumber);
                  });
                  return Text(
                    roundNumber,
                    style: const TextStyle(fontSize: 28),
                  );
                }
              } else {
                roundNumber = snapshot.data!.docs.map((doc) {
                  if (doc.get('id') != email && doc.get('isFirst') == "true") {
                    return doc.get('roundNumbers') as String?;
                  }
                }).firstWhere((element) => element != null, orElse: () => null);
                if (roundNumber != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // Ensure this runs after the current frame has been built
                    context
                        .read<GameState>()
                        .updateOtherPlayerValue(roundNumber);
                  });
                  return const Text(
                    '* * * *',
                    style: TextStyle(fontSize: 28),
                  );
                }
              }
            }
            return const Text(
              '* * * *',
              style: TextStyle(fontSize: 28),
            );
          },
        );
      },
    );
  }
}
