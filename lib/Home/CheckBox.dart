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
