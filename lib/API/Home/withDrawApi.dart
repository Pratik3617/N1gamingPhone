import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> withdrawAPI(String amount, String token, String withdrawId) async {
  var url = Uri.parse('https://backend.n1gaming.in/withdraw_request/');

  var data = {
    "withdrawal_id": withdrawId,
    "amount": int.parse(amount), // Ensure amount is an integer
  };
  
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };

  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  return response;
}
