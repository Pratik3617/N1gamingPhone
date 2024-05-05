// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final Color borderColor;

  Button({
    this.color = Colors.amber,
    this.borderColor = Colors.white,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
                width: MediaQuery.of(context).size.width * 0.04,
                height: MediaQuery.of(context).size.height * 0.051,
                margin: EdgeInsets.fromLTRB(5, 3, 2, 2),
                child: Center(
                  child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontFamily: "SanSerif",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: color,
                    contentPadding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                        width: 1.0,
                      ),
                    ),
                    
                  ),
                  
                ),
                )
              );
  }
}
