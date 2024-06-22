import 'package:flutter/material.dart';
import 'package:n1gaming/Register/OTPVerificationModal.dart';

void userNotVerified(BuildContext context, String message, String email) {
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
              'Verify',
              style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 14.0,
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return OTPVerificationdDialog(email: email,);
                },
              );
            },
          ),
        ],
      );
    },
  );
}
