import 'package:http/http.dart' as http;

Future<http.Response> addBankDetailsAPI(String accountNo, String name,String ifsc,String upi,String token) async {
  var url = Uri.parse('https://n1gaming-backend-app.onrender.com/save-bank-details/');

  var data = {
    "account_number": accountNo,
    "holder_name": name,
    "ifsc_code": ifsc,
    "upi_id": upi
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