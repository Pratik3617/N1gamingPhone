import 'package:flutter/material.dart';

class Check_Button extends StatelessWidget {
  Check_Button(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.onChange,
      required this.isChecked,
      this.fontSize = 12,
      this.decoration}
    );
  final String text;
  final double width;
  final double height;
  final ValueChanged<bool?> onChange;
  final bool isChecked;
  final double fontSize;
  BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 2),
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
        decoration: decoration ??
            BoxDecoration(
                color: Colors.amber,
                // border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(2.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
                checkColor: Colors.black,
                value: isChecked,
                onChanged: onChange,
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                fillColor: MaterialStateProperty.all<Color>(Colors.white)),
                
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