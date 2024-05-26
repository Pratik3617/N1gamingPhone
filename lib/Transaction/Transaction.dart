// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:n1gaming/Provider/TransactionProvider.dart';
import 'package:provider/provider.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

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
              cells.add(
                DataCell(
                  Text(rowList[i][j], style: const TextStyle(color: Colors.white,fontSize: 11)),
                ),
              );
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
          toolbarHeight: MediaQuery.of(context).size.height*0.15,
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
              fontSize: MediaQuery.of(context).size.height*0.05, // Adjust the font size as needed
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
                          columnSpacing: MediaQuery.of(context).size.height*0.05,
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
                              label: Text('Status', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                          ],
                          rows: rows,
                        ),
                      )
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
