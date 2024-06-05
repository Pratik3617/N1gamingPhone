// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:n1gaming/API/Login/forgotPasswordAPI.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Login/OTPmodal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String resetError = "";

  Future<int> resetPassword() async {
    var response = await forgotPassword(_emailController.text);
    var responseBody = json.decode(response.body);
    print("response body: ${response.statusCode}");
    if (response.statusCode == 200) {
      resetError = responseBody['message'];
    } else {
      resetError = responseBody['message'];
    }
    return response.statusCode;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Forgot Password',
        style: TextStyle(
          fontFamily: "YoungSerif",
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text(
              'Please enter your email to reset your password.',
              style: TextStyle(
                fontFamily: "SansSerif",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 30, 58, 58),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey, // Assigning the _formKey here
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              showLoadingDialog(context); // Show loading dialog
              int statusCode = await resetPassword();
              hideLoadingDialog(context); // Hide loading dialog
              print(statusCode);
              if (statusCode == 200) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return OTPmodal(email: _emailController.text);
                  },
                );
              } else {
                Navigator.of(context).pop();
                showErrorDialog(context, resetError);
              }
            }
          },
          child: const Text(
            'Send OTP',
            style: TextStyle(
              fontFamily: "SansSerif",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: "SansSerif",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 58),
            ),
          ),
        ),
      ],
    );
  }
}
