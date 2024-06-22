import 'package:http/http.dart' as http;

Future<http.Response> logoutAPI(String token) async {
  var url = Uri.parse('https://n1gaming-backend-app.onrender.com/logout/');


  var headers = {
    'Authorization': 'Token $token',
  };

  var response = await http.post(
    url,
    headers: headers
  );

  return response;
}