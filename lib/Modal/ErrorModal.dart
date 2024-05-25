import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontFamily: 'SansSerif',
            fontSize: 18.0,
            color: Colors.red
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
