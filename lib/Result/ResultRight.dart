// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// // import 'package:bet/Result.dart';
// import 'package:flutter/material.dart';
// import 'package:n1gaming/Provider/ResultProvider.dart';
// import 'package:provider/provider.dart';

// class ResultRight extends StatelessWidget {
//   List<String> listAlpha = ["Time", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"];

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ShowResultProvider>(
//       builder: (context, showResultProvider, child) {
//         List<dynamic> result = showResultProvider.data;
//         if (result.isEmpty){
//           return Center(
//             child: Text("No data available for the selected date!!!!"),
//           );
//         }else{
//           return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(
//                 21,
//                     (index) {
//                   double width = index == 0 ? 100.0 : 50.0;
//                   return Container(
//                     color: Colors.amberAccent,
//                     width: width,
//                     height: 30.0,
//                     child: Text(
//                       listAlpha[index],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20.0
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Scrollable content
//             Expanded(
//               child: ListView.builder(
//                 itemCount: result.length,
//                 itemBuilder: (context, row) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(
//                       21,
//                           (col) {
//                         double width = col == 0 ? 100.0 : 50.0;
//                         Color bgcolor = col == 0 ? Colors.teal : Colors.lightGreen;
//                         return Container(
//                           width: width,
//                           color: bgcolor,
//                           height: 30.0,
//                           margin: EdgeInsets.only(top: 2.0),
//                           padding: EdgeInsets.only(top: 2.0),
//                           child: Text(
//                             result[row][col].toString(),
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20.0,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//         }
//       },
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class ResultRight extends StatelessWidget {
  List<String> listAlpha = ["Time", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"];

  // Static data to use instead of provider
  List<List<dynamic>> staticData = [
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],

    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],
    ["10:00", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
    ["11:00", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"],

    // Add more static data rows as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            21,
            (index) {
              double width = index == 0 ? MediaQuery.of(context).size.width*0.055 : MediaQuery.of(context).size.width*0.03;
              return Container(
                color: Colors.amberAccent,
                width: width,
                height: MediaQuery.of(context).size.height*0.05,
                child: Text(
                  listAlpha[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width*0.02,
                  ),
                ),
              );
            },
          ),
        ),
        // Scrollable content
        Expanded(
          child: ListView.builder(
            itemCount: staticData.length,
            itemBuilder: (context, row) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  staticData[row].length,
                  (col) {
                    double width = col == 0 ? MediaQuery.of(context).size.width*0.055 : MediaQuery.of(context).size.width*0.03;
                    Color bgcolor = col == 0 ? Colors.teal : Colors.lightGreen;
                    return Container(
                      width: width,
                      color: bgcolor,
                      height: MediaQuery.of(context).size.height*0.05,
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text(
                        staticData[row][col].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width*0.02,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

