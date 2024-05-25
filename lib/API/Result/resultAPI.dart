import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>>  fetchResult(String token, DateTime date) async {
  final formattedDate = '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  print(formattedDate);
  var url = Uri.parse('https://n1gaming-backend-app.onrender.com/get-result?date=$formattedDate');

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

Future<Map<String, dynamic>> fetchDataForDate(DateTime date) async {
  final apiUrl = 'http://3.108.237.235/showResultApp';

  final formattedDate = '${date.year}-${date.month}-${date.day}';

  final response = await http.get(Uri.parse('$apiUrl?date=$formattedDate'));

  if (response.statusCode == 200 || response.statusCode == 404) {
    return json.decode(response.body);
  }else if (response.statusCode == 404) {
    return {'result': []};
  }else {
    throw Exception('Failed to fetch data for the date');
  }
}
