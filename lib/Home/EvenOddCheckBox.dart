import 'package:flutter/material.dart';

class EvenOddCheckBox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?)? onChanged; // Update type to accept nullable boolean

  EvenOddCheckBox({
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            visualDensity: VisualDensity(horizontal: -3, vertical: -3), // Adjust the values here
          ),
          Text(
            "All",
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),

          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            visualDensity: VisualDensity(horizontal: -3, vertical: -3), // Adjust the values here
          ),
          Text(
            "Even",
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),

          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            visualDensity: VisualDensity(horizontal: -3, vertical: -3), // Adjust the values here
          ),
          Text(
            "Odd",
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),
        ],
      ),)
    );
  }
}

