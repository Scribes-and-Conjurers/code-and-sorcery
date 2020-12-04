import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  // These are the states for the logged in user
  String _uID;
  String _username = 'try';
  String _email;
  String _guild;
  String _playerClass;
  int _points;

  // These are the getters that returns the values for the user's states
  String get uID => _uID;
  String get username => _username;
  String get email => _email;
  String get guild => _guild;
  String get playerClass => _playerClass;
  int get points => _points;

  // This function sets the value for uID
  // notifyListeners() calls all registered listeners
  // When _uID changes, anything listening to it updates uID with the new val
  // set uID(String val) {
  //   _uID = val;
  //   notifyListeners();
  // }

  // This void function updates the uID
  // void updateuID(String value) {
  //   _uID = value;
  //   notifyListeners();
  // }

  void testPress() {
    _uID = 'testing';
    print(_uID);
  }
}


