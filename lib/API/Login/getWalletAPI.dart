import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchBalance(String token) async {
  var url = Uri.parse('https://backend.n1gaming.in/get-balance');

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };

  var response = await http.get(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('walletBalance', data['balance']);
      
    } else {
      throw Exception('Failed to get balance!!!');
    }

}