// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;

Future<http.Response> resetPassword(String email,String password) async {
  var url = Uri.parse('https://backend.n1gaming.in/reset-password/');

  var data = {
    'email': email,
    'new_password':password,
  };

  // Send the POST request
  var response = await http.post(
    url,
    body: data,
  );

  return response;
}
