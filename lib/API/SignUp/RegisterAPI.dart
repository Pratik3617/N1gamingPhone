// ignore_for_file: avoid_print


import 'package:http/http.dart' as http;

Future<http.Response> registerUser(String username, String email, String password) async {
  var url = Uri.parse('https://n1gaming-backend-app.onrender.com/register/');

  var data = {
    'username': username,
    'email': email,
    'password': password,
  };

  // Send the POST request
  var response = await http.post(
    url,
    body: data,
  );

  return response;
}
