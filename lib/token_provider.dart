import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier{
  String? _accessToken;

  String? get accessToken => _accessToken;

  void setAccessToken(String token){

      _accessToken=token;
      notifyListeners();
  }
}