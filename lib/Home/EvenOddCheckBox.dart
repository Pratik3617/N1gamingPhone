import 'package:flutter/material.dart';

class EvenOddCheckBox extends StatelessWidget {
  final bool isCheckedAll;
  final bool isCheckedEven;
  final bool isCheckedOdd;
  final void Function(bool?)? onChangedAll; // Update type to accept nullable boolean
  final void Function(bool?)? onChangedEven; 
  final void Function(bool?)? onChangedOdd; 

  EvenOddCheckBox({
    required this.isCheckedAll,
    required this.isCheckedEven,
    required this.isCheckedOdd,
    required this.onChangedAll,
    required this.onChangedEven,
    required this.onChangedOdd,
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
            value: isCheckedAll,
            onChanged: onChangedAll,
            visualDensity: const VisualDensity(horizontal: -3, vertical: -3), // Adjust the values here
          ),
          const Text(
            "All",
            style: TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),

          Checkbox(
            value: isCheckedEven,
            onChanged: onChangedEven,
            visualDensity: const VisualDensity(horizontal: -3, vertical: -3), // Adjust the values here
          ),
          const Text(
            "Even",
            style: TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),

          Checkbox(
            value: isCheckedOdd,
            onChanged: onChangedOdd,
            visualDensity: const VisualDensity(horizontal: -3, vertical: -3), // Adjust the values here
          ),
          const Text(
            "Odd",
            style: TextStyle(
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

