import 'package:flutter/material.dart';
// import 'package:learnlyapp/helpers/enums/app-state.dart';

class BaseViewModel extends ChangeNotifier {
  // AppState _appState = AppState.idle;
  // AppState get appState => _appState;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void setErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  // void setAppState(AppState state) {
  //   _appState = state;
  //   notifyListeners();
  // }

  // void setUserToken(String token) {
  //   _userToken = token;
  //   notifyListeners();
  // }
}
