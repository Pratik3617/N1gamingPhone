import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchUsername(String token) async {
  var url = Uri.parse('https://n1gaming-backend-app.onrender.com/get-username');

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
      await prefs.setString('username', data['username']);
      
    } else {
      throw Exception('Failed to get username!!!');
    }

}