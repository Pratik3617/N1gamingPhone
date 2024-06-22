import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:n1gaming/Account/accountBox.dart';
import 'dart:convert';

class AccountHistoryProvider with ChangeNotifier {
  List<AccountDetails> _accountHistory = [];
  bool _isLoading = false;

  List<AccountDetails> get accountHistory => _accountHistory;
  bool get isLoading => _isLoading;

  Future<void> fetchAccountHistory(String token) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://n1gaming-backend-app.onrender.com/account_history');
    final headers = {'Authorization': 'Token $token'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _accountHistory = data.map((item) => AccountDetails.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      // Handle the error as necessary
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}