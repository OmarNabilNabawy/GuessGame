import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guess/features/game_feature/data/models/scoring_model.dart';

class GameState extends ChangeNotifier {
  String? _myValue;
  String? _otherPlayerValue;

  String? get myValue => _myValue;
  String? get otherPlayerValue => _otherPlayerValue;

  List<ScoringModel> scoringList = [];

  void updateMyValue(String? value) {
    if (value != _myValue) {
      _myValue = value;
      notifyListeners();
    }
  }

  void updateOtherPlayerValue(String? value) {
    if (value != _otherPlayerValue) {
      _otherPlayerValue = value;
      notifyListeners();
    }
  }

  void updateScore(bool isMe, String collectionName) {
    final roomScore = scoringList
        .firstWhere((roomsNames) => roomsNames.roomName == collectionName);
    if (isMe) {
      roomScore.myScore += 1;
    } else {
      roomScore.myFriendScore += 1;
    }
    notifyListeners();
  }
}
