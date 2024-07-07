import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> paymentAPI(
  String amount,
  String txnId,
  File paymentImage,
  String paymentMethod,
  String upiId,
  String token,
) async {
  var url = Uri.parse('https://backend.n1gaming.in/recharge_request/');

  var request = http.MultipartRequest('POST', url)
    ..headers['Authorization'] = 'Token $token'
    ..fields['amount'] = amount
    ..fields['txn_id'] = txnId
    ..fields['payment_method'] = paymentMethod
    ..fields['upi_id'] = upiId
    ..files.add(await http.MultipartFile.fromPath('payment_image', paymentImage.path));

  var response = await request.send();
  return await http.Response.fromStream(response);
}
