// ignore_for_file: prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:n1gaming/Login/OTPmodal.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              showDialog(context: context, 
                builder: (BuildContext context) {
                  return OTPmodal(email: _emailController.text,);
                }
              );
            }
            
            // Perform password reset functionality here
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
