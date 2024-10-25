import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/features/game_feature/presentation/manager/provider/game_state.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/first_number_widget.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/round_number_body_list_view.dart';
import 'package:guess/features/game_feature/presentation/views/widgets/text_field_stream_builder.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final String collectionName =
        ModalRoute.of(context)?.settings.arguments as String;
    CollectionReference messages =
        FirebaseFirestore.instance.collection(collectionName);
    TextEditingController textEditingController = TextEditingController();
    String? email = FirebaseAuth.instance.currentUser!.email;
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FirstNumberWidget(
                      collectionName: collectionName,
                      email: email,
                      isMe: true,
                    ),
                    FirstNumberWidget(
                      collectionName: collectionName,
                      email: email,
                      isMe: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 13,
                child: Row(
                  children: [
                    Expanded(
                      child: RoundNumberBodyListView(
                        collectionName: collectionName,
                        email: email,
                        roundValue: gameState.myValue,
                        isMe: false,
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      width: 2,
                    ),
                    Expanded(
                      child: RoundNumberBodyListView(
                        collectionName: collectionName,
                        email: email,
                        roundValue: gameState.otherPlayerValue,
                        isMe: true,
                      ),
                    )
                  ],
                ),
              ),
              TextFieldStreamBuilder(
                collectionName: collectionName,
                textEditingController: textEditingController,
                email: email,
                messages: messages,
              )
            ],
          ),
        );
      },
    );
  }
}
