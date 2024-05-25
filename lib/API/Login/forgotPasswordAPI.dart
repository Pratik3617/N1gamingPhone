// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;

Future<http.Response> forgotPassword(String email) async {
  var url = Uri.parse('https://n1gaming-backend-app.onrender.com/reset-password/request/');

  var data = {
    'email': email,
  };

  // Send the POST request
  var response = await http.post(
    url,
    body: data,
  );

  return response;
}
