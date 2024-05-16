import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 CustomButton(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.onClick, this.decoration});
  final String text;
  final double width;
  final double height;
  final VoidCallback onClick;
  BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          decoration: decoration ?? BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.yellow, width: 2.0),
              borderRadius: BorderRadius.circular(2.0)),
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: "SansSerif",
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          )),
    );
  }
}
