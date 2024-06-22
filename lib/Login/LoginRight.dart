// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:n1gaming/Login/ForgotPassModal.dart';
import 'package:n1gaming/Modal/notVerifiedUser.dart';
import 'package:n1gaming/Register/OTPVerificationModal.dart';
import 'package:n1gaming/Register/Register.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:n1gaming/API/Login/LoginAPI.dart';
import 'package:n1gaming/API/Login/getUsernameAPI.dart';
import 'package:n1gaming/API/Login/getWalletAPI.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Home/Home.dart';

class RightContent extends StatefulWidget {
  const RightContent({super.key});

  @override
  _RightContentState createState() => _RightContentState();
}

class _RightContentState extends State<RightContent> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String loginError = "";
  bool _isLoading = false; // Add a boolean to track the loading state

  Future<int> userLogin() async {
    var response = await loginUser(_emailController.text, _passwordController.text);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = responseBody['token'];
      await prefs.setString('token', token);
      await prefs.setBool('isLoggedIn', true);

      await fetchUsername(token);
      await fetchBalance(token);
    } else {
      loginError = responseBody['message'];
    }
    _emailController.text = "";
    _passwordController.text = "";

    return response.statusCode;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
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
                    "Login",
                    style: TextStyle(
                        fontFamily: "YoungSerif",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 1),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ForgotPasswordDialog();
                        },
                      );
                    },
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                          fontFamily: "SansSerif",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 1),
                  ElevatedButton(
                    onPressed: () async {
                      if (_validateInputs()) {
                        showLoadingDialog(context);
                        int statusCode = await userLogin();
                        hideLoadingDialog(context);
                        print(statusCode);
                        if (statusCode == 200) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        }else if(statusCode == 400){
                          userNotVerified(context, "User already registered with given mail id!!! Please complete email verification.", _emailController.text);
                        }else{
                          showErrorDialog(context, loginError);
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 58, 58)),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontFamily: "YoungSerif",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 1),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Not Registered yet? Sign Up',
                      style: TextStyle(
                          fontFamily: "SansSerif",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
