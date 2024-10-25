import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  String? _myValue;
  String? _otherPlayerValue;

  String? get myValue => _myValue;
  String? get otherPlayerValue => _otherPlayerValue;

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
}
