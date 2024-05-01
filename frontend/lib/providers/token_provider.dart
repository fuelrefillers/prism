import 'package:flutter/material.dart';
import 'package:frontend/models/token_model.dart';

class TokenProvider extends ChangeNotifier {
  Token _token = Token(token: '');

  Token get token => _token;

  void setToken(String token) {
    _token = Token.fromJson(token);
    notifyListeners();
  }

  void setTokenFromModel(Token user) {
    _token = token;
    notifyListeners();
  }
}
