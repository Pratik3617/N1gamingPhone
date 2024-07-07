import 'package:http/http.dart' as http;

Future<http.Response> getQR(String token) async {
  var url = Uri.parse('https://backend.n1gaming.in/get_payment_qr');

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };

  var response = await http.get(
    url,
    headers: headers,
  );

  return response;

}