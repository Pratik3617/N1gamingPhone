// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n1gaming/API/Login/resetPasswordAPI.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/successModal.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({super.key, required this.email});
  final String email;
  @override
  _ResetPasswordDialogState createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String resetError = "";

  Future<int> forgotUserPassword() async {
    var response = await resetPassword(widget.email, _newPasswordController.text);
    var responseBody = json.decode(response.body);
    resetError = responseBody['message'];
    return response.statusCode;
  }

  

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Create new Password',
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
            Form(
              key: _formKey, // Assigning the _formKey here
              child: Column(
                children: [
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'New Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Please enter a password of length greater than 6';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              showLoadingDialog(context);
              int statusCode = await forgotUserPassword();
              hideLoadingDialog(context); 
              if (statusCode == 200) {
                showSuccessDialog(context, resetError);
              } else {
                showErrorDialog(context, resetError);
              }
            }
          },
          child: const Text(
            'Change Password',
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
