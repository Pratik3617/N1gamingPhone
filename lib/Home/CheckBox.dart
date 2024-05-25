// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CheckBoxWithContent extends StatelessWidget {
  final bool isChecked;
  final String content;
  final void Function(bool?)? onChanged; // Update type to accept nullable boolean

  CheckBoxWithContent({
    required this.isChecked,
    required this.content,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4), // Adjust the values here
          ),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),
        ],
      ),
    );
  }
}


class InputField extends StatelessWidget {
  InputField(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.onChange,
      this.fontSize = 20,
      this.decoration});
  final String text;
  final double width;
  final double height;
  final ValueChanged<String> onChange;
  final double fontSize;
  BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
        decoration: decoration ??
            BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.yellow, width: 2.0),
                borderRadius: BorderRadius.circular(2.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50.0,
              height: 28.0,
              child: TextField(
                onChanged: onChange,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontFamily: "SanSerif",
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.orange.shade200,
                  contentPadding:
                      const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
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
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              style: TextStyle(
                  fontFamily: "SansSerif",
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ));
  }
}

