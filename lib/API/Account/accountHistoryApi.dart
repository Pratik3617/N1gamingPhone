// import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response>  accounHistoryAPI(String token) async {
  var url = Uri.parse('https://backend.n1gaming.in/account_history');

  var headers = {
    'Authorization': 'Token $token',
  };

  var response = await http.get(url, headers: headers);

  // if (response.statusCode == 200 || response.statusCode == 404) {
  //   print(response.body);
  //   return json.decode(response.body);
  // }else if (response.statusCode == 404) {
  //   return {'result': []};
  // }else {
  //   throw Exception('Failed to fetch data for the date');
  // }
  return response;
}
