import 'package:http/http.dart' as http;

Future<http.Response> changePassword(String currentPassword, String newPassword, String token) async {
  var url = Uri.parse('https://backend.n1gaming.in/update-password/');

  var data = {
    "current_password": currentPassword,
    "new_password": newPassword
  };

  var headers = {
    'Authorization': 'Token $token',
  };

  var response = await http.post(
    url,
    body: data,
    headers: headers
  );

  return response;
}