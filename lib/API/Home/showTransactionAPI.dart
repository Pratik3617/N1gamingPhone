import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:n1gaming/Provider/TransactionProvider.dart';

Future<void> fetchTransactionAPI(String token, TransactionProvider transactionProvider) async {
  var url = Uri.parse('https://backend.n1gaming.in/transaction/');

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };

  var response = await http.get(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    
    final Map<String, dynamic> responseData = json.decode(response.body);
    Map<String, List<List<String>>> transactionData = {};

    if (responseData.containsKey('transactionList')) {
      List<dynamic> transactions = responseData['transactionList'];

      for (var transaction in transactions) {
        if (transaction.containsKey('transaction_id') && transaction.containsKey('tsns')) {
          String transactionId = transaction['transaction_id'];
          List<dynamic> tsns = transaction['tsns'];

          List<List<String>> tsnsData = [];

          for (var tsn in tsns) {
            if (tsn.containsKey('tsn_id') &&
                tsn.containsKey('gamedate_time') &&
                tsn.containsKey('slipdatetime') &&
                tsn.containsKey('playedpoints')) {
                  tsnsData.add([
                    tsn['tsn_id'],
                    '2D coupon',
                    tsn['gamedate_time'],
                    tsn['slipdatetime'],
                    tsn['playedpoints'].toString(),
                    tsn['winning'].toString(),
                  ]);
                }
          }

          transactionData[transactionId] = tsnsData;
        }
      }

      transactionProvider.updateTransactionData(transactionData);
    }
  } else {
    print('Error: ${response.statusCode}, ${response.reasonPhrase}');
  }

}