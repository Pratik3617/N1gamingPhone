import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/tsnDetailsModal.dart';
import 'package:n1gaming/Provider/TransactionProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  Future<http.Response> _showDetailsDialog(String tsnId, String token) async {
    final url = 'https://backend.n1gaming.in/get-usergame?tsn_id=$tsnId'; 
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        List<DataRow> rows = [];

        transactionProvider.transactionData.forEach((transactionId, rowList) {
          for (int i = 0; i < rowList.length; i++) {
            List<DataCell> cells = [];

            if (i == 0) {
              cells.add(DataCell(Text(transactionId, style: const TextStyle(color: Colors.white, fontSize: 11))));
            } else {
              cells.add(DataCell(const Text('')));
            }

            for (int j = 0; j < rowList[i].length; j++) {
              if (j == 0) {
                cells.add(
                  DataCell(
                    GestureDetector(
                      onTap: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        var token = prefs.getString('token');
                        showLoadingDialog(context);
                        var response = await _showDetailsDialog(rowList[i][j], token!);
                        var responseBody = json.decode(response.body);

                        final userGameList = responseBody['usergame'];
                        final formattedDetails = userGameList.map((game) {
                          return '${game['game_name']}-${game['number']}-${game['Playedpoints']}';
                        }).join(', ');
                        print(formattedDetails);
                        hideLoadingDialog(context);
                        if (response.statusCode == 200) {
                          tsnDetailsDialog(context, formattedDetails, rowList[i][j]);
                        } else {
                          final message = responseBody['message'];
                          showErrorDialog(context, message);
                        }
                      },
                      child: Text(
                        rowList[i][j],
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                );
              } else {
                // Winning column
                if (j == rowList[i].length - 1) {
                  String winningValue = rowList[i][j];
                  Color textColor = winningValue.toLowerCase() == 'live' ? Colors.red : Colors.green;

                  cells.add(
                    DataCell(
                      Text(
                        rowList[i][j],
                        style: TextStyle(color: textColor, fontSize: 11),
                      ),
                    ),
                  );
                } else {
                  cells.add(
                    DataCell(
                      Text(rowList[i][j], style: const TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  );
                }
              }
            }

            while (cells.length < 7) {
              cells.add(const DataCell(Text('')));
            }

            rows.add(DataRow(
              cells: cells,
            ));
          }
        });

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.15,
            backgroundColor: Color.fromARGB(255, 30, 58, 58),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.white,
            ),
            title: Text(
              "N.1 GAMING",
              style: TextStyle(
                fontFamily: 'YoungSerif',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.05, // Adjust the font size as needed
                color: Colors.white,
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.center,
            ),
            centerTitle: true, // Center the title
          ),
          body: Scaffold(
            backgroundColor: const Color.fromARGB(255, 42, 41, 41),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 20, 15),
                            child: const Text("Click on TSN for Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: MediaQuery.of(context).size.height * 0.05,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Transaction ID', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('TSN', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('GAME', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Game Date Time', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Slip Date Time', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Points', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Winning', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                          ],
                          rows: rows,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
