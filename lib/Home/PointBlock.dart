// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class PointsBlock extends StatelessWidget {
  const PointsBlock({super.key, required this.text1, required this.text2, this.color=Colors.amberAccent, this.textColor=Colors.white});
  final String text1;
  final String text2;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context){

    return Container(
      width: MediaQuery.of(context).size.width * 0.11,
      height: MediaQuery.of(context).size.height * 0.06,
      margin: const EdgeInsets.fromLTRB(3.0, 2.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.054,
              height: MediaQuery.of(context).size.height * 0.06,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 0.0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius : BorderRadius.circular(2.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: textColor
                    ),
                  )
                ],
              )
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.054,
              height: MediaQuery.of(context).size.height * 0.06,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 0.0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius : BorderRadius.circular(2.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text2,
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: textColor
                  ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}