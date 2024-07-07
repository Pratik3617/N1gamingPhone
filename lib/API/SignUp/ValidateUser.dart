// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;

Future<http.Response> validateUser(String email, String otp) async {
  var url = Uri.parse('https://backend.n1gaming.in/validate-otp/');

  var data = {
    'email': email,
    'otp': otp,
  };

  // Send the POST request
  var response = await http.post(
    url,
    body: data,
  );

  return response;
}
