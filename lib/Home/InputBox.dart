// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Input_Box extends StatelessWidget {
  final String text;
  final Color color;
  final TextEditingController controller;
  final ValueChanged<String> onChange;

  Input_Box(
      {super.key,
      required this.text,
      required this.color,
      required this.controller,
      required this.onChange}
  );
  

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 2, 3),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextField(
                  onChanged: onChange,
                  keyboardType: TextInputType.number,
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontFamily: "SanSerif",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: color,
                    contentPadding:
                         EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  }
}
