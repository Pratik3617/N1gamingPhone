// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:n1gaming/Provider/ResultProvider.dart';
import 'package:provider/provider.dart';

class ResultRight extends StatelessWidget {
  List<String> listAlpha = ["Time", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"];

  ResultRight({super.key});

  // Static data to use instead of provider
  

  @override
  Widget build(BuildContext context) {
    return Consumer<ShowResultProvider>(
      builder: (context, showResultProvider, child) {
        List<dynamic> result = showResultProvider.data;
        if (result.isEmpty){
          return Center(
            child: Text("No data available for the selected date!!!!"),
          );
        }else{
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  21,
                  (index) {
                    double width = index == 0 ? MediaQuery.of(context).size.width * 0.095 : MediaQuery.of(context).size.width * 0.03;
                    return Container(
                      color: Colors.amberAccent,
                      width: width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Text(
                        listAlpha[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(height: 5), // Adjust the height here
              // Scrollable content
              Expanded(
              child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      21,
                          (col) {
                        double width = col == 0 ? MediaQuery.of(context).size.width * 0.095 : MediaQuery.of(context).size.width * 0.03;
                        Color bgcolor = col == 0 ? Colors.teal : Colors.lightGreen;
                        return Container(
                          width: width,
                          color: bgcolor,
                          height: MediaQuery.of(context).size.height * 0.06,
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text(
                            result[row][col].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * 0.02,
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
      },
    );
  }
}



