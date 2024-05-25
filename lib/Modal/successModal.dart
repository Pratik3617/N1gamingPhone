import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Success',
          style: TextStyle(
            fontFamily: 'SansSerif',
            fontSize: 18.0,
            color: Colors.green
          ),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 14.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
