// ignore_for_file: prefer_final_fields, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n1gaming/API/SignUp/RegisterAPI.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Login/Login.dart';
import 'package:n1gaming/Modal/notVerifiedUser.dart';
import 'package:n1gaming/Register/OTPVerificationModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterRightContent extends StatefulWidget {
  const RegisterRightContent({super.key});

  @override
  RegisterRightContentState createState() => RegisterRightContentState();
}
  
class RegisterRightContentState extends State<RegisterRightContent> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var error = "";

  Future<int> userRegister() async {
    var response = await registerUser(_userNameController.text, _emailController.text, _passwordController.text);

    if (response.statusCode == 201) {
      print('Response: ${response.body}');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _userNameController.text);
      await prefs.setInt('walletBalance', 0);
    } else {
      final responseBody = jsonDecode(response.body);
      error = responseBody['message'];
    }

    return response.statusCode;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid
      return true;
    } else {
      // At least one field is invalid
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 18, 39, 39),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontFamily: "YoungSerif",
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 1),
              TextFormField(
                controller: _userNameController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () async{
                  if (_validateInputs()) {
                    showLoadingDialog(context);
                    int statusCode = await userRegister();
                    hideLoadingDialog(context);
                    if(statusCode == 201){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OTPVerificationdDialog(email: _emailController.text,);
                        },
                      );
                    }else if(statusCode==200){
                      userNotVerified(context, "User already registered with given mail id!!! Please complete email verification.", _emailController.text);
                    }else{
                      showErrorDialog(context, error);
                    }
                  }
                 
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 30, 58, 58)),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: "YoungSerif",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1
                  ),
                ),
              ),
              const SizedBox(height: 1),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'Already Registered? Sign In',
                  style: TextStyle(
                    fontFamily: "SansSerif",
                    fontSize: 14,
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
