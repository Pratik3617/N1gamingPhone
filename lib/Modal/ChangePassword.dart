// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n1gaming/API/Home/changePasswordAPI.dart';
import 'package:n1gaming/Login/Login.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/successModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassModal extends StatefulWidget {
  const ChangePassModal({super.key});

  @override
  ChangePassModalState createState() => ChangePassModalState();
}

class ChangePassModalState extends State<ChangePassModal> {
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? token;
  String message= "";

  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  Future<int> changeUserPassword() async{
    var response = await changePassword(_currentPassword.text,_newPassword.text,token!);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      message = responseBody['message'];
    } else {
      message = responseBody['message'];
    }
    _currentPassword.text="";
    _newPassword.text="";
    _confirmPassword.text="";
    
    return response.statusCode;
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero, // Remove padding around the dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.95,
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text("Change Password",
              textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 58, 58),
                  ),
              ),
              Form(
                key: _formKey, // Assigning the _formKey here
                child: Column(
                  children: [
                    TextFormField(
                      controller: _currentPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Current Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: _newPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'New Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _newPassword.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    int statusCode = await changeUserPassword();
                    hideLoadingDialog(context);
                    Navigator.of(context).pop();
                    if(statusCode == 200){                   
                      showSuccessDialog(context, message);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }else{
                      Navigator.of(context).pop();
                      showErrorDialog(context, message);
                    }
                  }
                },
                style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 58, 58)),
                    ),
                
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontFamily: "YoungSerif",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
