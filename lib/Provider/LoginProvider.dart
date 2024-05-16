// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;

  User({required this.username});
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  Future<void> setUser(String username) async {
    _user = User(username: username);
    notifyListeners();

    // Save user data to shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username != null) {
      _user = User(username: username);
      notifyListeners();
    }
  }

  void logout() async {
    _user = null;
    notifyListeners();

    // Remove user data from shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }
}
