import 'package:flutter/material.dart';

void tsnDetailsDialog(BuildContext context, String message, String tsnId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          tsnId,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.0,
            color: Color.fromARGB(255, 30, 58, 58)
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ),
        
      );
    },
  );
}
