import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guess/constants.dart';
import 'package:guess/core/fire_base_service.dart';
import 'package:guess/core/helper/show_snack_bar.dart';
import 'package:guess/features/game_feature/data/models/round_numbers_model.dart';
import 'widgets/game_text_field.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    CollectionReference messages =
        FirebaseFirestore.instance.collection(kMessagesCollections);
    FireBaseServices fireBaseServices = FireBaseServices();
    TextEditingController textEditingController = TextEditingController();
    String? myValue;
    String? otherPlayerValue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder<String>(
                    future: fireBaseServices.getFirstValue(
                        email: email, isEqual: true),
                    builder: (context, firstRoundNumbers) {
                      if (firstRoundNumbers.hasData) {
                        myValue = firstRoundNumbers.data;
                        return Text(
                          firstRoundNumbers.data!,
                          style: const TextStyle(fontSize: 28),
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ));
                      }
                    }),
                FutureBuilder<String>(
                    future: fireBaseServices.getFirstValue(
                        email: email, isEqual: false),
                    builder: (context, firstRoundNumbers) {
                      if (firstRoundNumbers.hasData) {
                        otherPlayerValue = firstRoundNumbers.data;
                        return const Text(
                          '* * * *',
                          style: TextStyle(fontSize: 28),
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ));
                      }
                    }),
              ],
            ),
          ),
          Expanded(
            flex: 13,
            child: Row(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: messages
                          .where('isFirst', isEqualTo: 'false')
                          .where('id', isNotEqualTo: email)
                          .orderBy(kCreatedAt, descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<String> roundNumberList = [];
                          roundNumberList.addAll(snapshot.data!.docs.map((doc) {
                            return doc.get('roundNumbers') as String;
                          }).toList());

                          return ListView.builder(
                            itemCount: roundNumberList.length,
                            itemBuilder: (context, index) {
                              int numberOfMatches = 0;
                              for (int i = 0; i < 4; i++) {
                                if (roundNumberList[index][i] == myValue?[i]) {
                                  numberOfMatches++;
                                }
                                if (numberOfMatches == 4) {
                                  Navigator.pushNamed(context, winViewRoute,
                                      arguments: email);
                                }
                              }
                              return RoundItem(
                                roundNumberModel: RoundNumberModel(
                                    firstNumber: roundNumberList[index][0],
                                    secondNumber: roundNumberList[index][1],
                                    thirdNumber: roundNumberList[index][2],
                                    forthNumber: roundNumberList[index][3],
                                    numOfMatches: numberOfMatches.toString()),
                              );
                            },
                          );
                        } else {
                          return const Center(child: SizedBox());
                        }
                      }),
                ),
                Container(
                  color: Colors.grey,
                  width: 2,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: messages
                          .where('isFirst', isEqualTo: 'false')
                          .where('id', isEqualTo: email)
                          .orderBy(kCreatedAt, descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<String> roundNumberList = [];
                          roundNumberList.addAll(snapshot.data!.docs.map((doc) {
                            return doc.get('roundNumbers') as String;
                          }).toList());

                          return ListView.builder(
                            itemCount: roundNumberList.length,
                            itemBuilder: (context, index) {
                              int numberOfMatches = 0;
                              for (int i = 0; i < 4; i++) {
                                if (roundNumberList[index][i] ==
                                    otherPlayerValue?[i]) {
                                  numberOfMatches++;
                                }
                                if (numberOfMatches == 4) {
                                  Navigator.pushNamed(context, winViewRoute,
                                      arguments: email);
                                }
                              }
                              return RoundItem(
                                roundNumberModel: RoundNumberModel(
                                    firstNumber: roundNumberList[index][0],
                                    secondNumber: roundNumberList[index][1],
                                    thirdNumber: roundNumberList[index][2],
                                    forthNumber: roundNumberList[index][3],
                                    numOfMatches: numberOfMatches.toString()),
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ));
                        }
                      }),
                )
              ],
            ),
          ),
          GameTextField(
            textEditingController: textEditingController,
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
          )
        ],
      ),
    );
  }
}

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
