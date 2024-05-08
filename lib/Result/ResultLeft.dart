// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:n1gaming/Home/Home.dart';
import 'package:n1gaming/Result/ResultDateForm.dart';

class ResultLeft extends StatefulWidget{
  @override
  _Left createState() => _Left();
}

class _Left extends State<ResultLeft>{

  void goBack() {
    Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
  }

  DateTime _dateTime = DateTime.now();
  
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
    ).then((value) => {
      setState(() {
        _dateTime = value!;
      })
    });
  }


  @override
  Widget build(BuildContext context){
    // MediaQueryData mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("N.1 GAMING", style: TextStyle(
          fontFamily: 'YoungSerif',
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.025,
          color: Color(0xFFF3FDE8),
          letterSpacing: 1.0,
          
        ),),

        ResultDateForm(),

        Container(
          width: MediaQuery.of(context).size.width*0.12,
          height: MediaQuery.of(context).size.height*0.08,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.05),
          child: ElevatedButton(
            onPressed: goBack,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3FDE8)),
              ),
            child: Text("Back", style: TextStyle(
              color: Colors.indigo,
              fontSize: MediaQuery.of(context).size.height*0.035,
              fontFamily: "SansSerif",
              fontWeight: FontWeight.bold,
              letterSpacing: 1
            ),),
            ),
        ),

      ],
    );
  }
}