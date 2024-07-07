import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>>  fetchResult(String token, DateTime date) async {
  final formattedDate = '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  var url = Uri.parse('https://backend.n1gaming.in/get-result?date=$formattedDate');

  var headers = {
    'Authorization': 'Token $token',
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200 || response.statusCode == 404) {
    return json.decode(response.body);
  }else if (response.statusCode == 404) {
    return {'result': []};
  }else {
    throw Exception('Failed to fetch data for the date');
  }
}
