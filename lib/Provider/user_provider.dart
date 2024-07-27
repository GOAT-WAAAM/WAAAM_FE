import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _nickname = '';
  String _goal = '';

  String get nickname => _nickname;
  String get goal => _goal;

  void setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  void setGoal(String goal) {
    _goal = goal;
    notifyListeners();
  }
}
