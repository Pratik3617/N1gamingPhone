
import 'package:flutter/material.dart';
import 'package:n1gaming/Result/ResultLeft.dart';
import 'package:n1gaming/Result/ResultRight.dart';

class Result extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  color: Colors.blueGrey,
                  child: ResultLeft(),
                )
            ),
            Expanded(
                flex: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: ResultRight(),
                )
            ),
          ],
        ),
    );
  }
}