// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, use_super_parameters

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n1gaming/API/SignUp/ResendOTP.dart';
import 'package:n1gaming/API/SignUp/ValidateUser.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:n1gaming/Home/Home.dart';

class OTPVerificationdDialog extends StatefulWidget {
  final String email;

  const OTPVerificationdDialog({Key? key, required this.email}) : super(key: key);

  @override
  _OTPVerificationdDialogState createState() => _OTPVerificationdDialogState();
}

class _OTPVerificationdDialogState extends State<OTPVerificationdDialog> {
  late List<TextEditingController> controllers;
  late FocusNode focusNode;
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  int _start = 120;
  String message1 =  "";
  String message2 = "";

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (index) => TextEditingController());
    focusNode = FocusNode();

    startTimer();
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    focusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String maskEmail(String email) {
    List<String> parts = email.split('@');

    if (parts.length != 2) {
      return email;
    }

    String username = parts[0];
    String domain = parts[1];

    String maskedUsername = username.replaceRange(0, username.length - 4, '*' * (username.length - 4));

    return maskedUsername + '@' + domain;
  }

  String getConcatenatedValues() {
    String concatenatedString = '';
    for (TextEditingController controller in controllers) {
      concatenatedString += controller.text;
    }
    return concatenatedString;
  }

  Future<int> userValidation() async {
    String otp = getConcatenatedValues();
    var response = await validateUser(widget.email, otp);
    var responseBody = json.decode(response.body);
    final token = responseBody['token'];
    if(response.statusCode!=200){
      message2 = responseBody['message'];
    }
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    
    return response.statusCode; 
  }

  Future<int> resendOtp() async {
    var response = await resendOTP(widget.email);
    for (TextEditingController controller in controllers) {
      controller.text = "";
    }
    var responseBody = json.decode(response.body);
    if(response.statusCode != 200){
      message1 = responseBody['message'];
    }
    return response.statusCode; 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Enter OTP',
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
            Text(
              'Please enter the OTP sent to your email ${maskEmail(widget.email)}',
              style: const TextStyle(
                fontFamily: "SansSerif",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 30, 58, 58),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: controllers[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          autofocus: index == 0,
                          decoration: const InputDecoration(
                            counter: Offstage(),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            } else if (value.length != 1) {
                              return 'Invalid OTP';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            if (value.length == 1 && index < controllers.length - 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _start == 0
                      ? ElevatedButton(
                          onPressed: () async{
                            showLoadingDialog(context);
                            int statusCode = await resendOtp();
                            hideLoadingDialog(context);
                            if(statusCode == 200){
                              setState(() {
                                _start = 120;
                              });
                              startTimer();
                            }else{
                              showErrorDialog(context, message1);
                            }
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontFamily: "SansSerif",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 30, 58, 58),
                            ),
                          ),
                        )
                      : Text(
                          'Resend OTP in ${formatTimer(_start)}',
                          style: const TextStyle(
                            fontFamily: "SansSerif",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 30, 58, 58),
                          ),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        showLoadingDialog(context);
                        int statusCode = await userValidation();
                        hideLoadingDialog(context);
                        if(statusCode == 200){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        }else{
                          for (TextEditingController controller in controllers) {
                            controller.text = "";
                          }
                          showErrorDialog(context, message2);
                        }
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: "SansSerif",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


