import 'dart:async';
import 'package:flutter/material.dart';

class OTPmodal extends StatefulWidget {
  const OTPmodal({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  OTPmodalDialogState createState() => OTPmodalDialogState();
}

class OTPmodalDialogState extends State<OTPmodal> {
  late List<TextEditingController> controllers;
  late FocusNode focusNode;
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  int _start = 120; // 2 minutes in seconds

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each input
    controllers = List.generate(6, (index) => TextEditingController());
    focusNode = FocusNode();

    // Start the timer when the widget initializes
    startTimer();
  }

  @override
  void dispose() {
    // Dispose controllers, focus node, and timer to prevent memory leaks
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
    // Convert seconds to minutes and seconds
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String maskEmail(String email) {
    // Split the email address into username and domain
    List<String> parts = email.split('@');

    if (parts.length != 2) {
      // Invalid email format
      return email;
    }

    String username = parts[0];
    String domain = parts[1];

    // Mask the username
    String maskedUsername =
        username.replaceRange(0, username.length - 4, '*' * (username.length - 4));

    // Combine masked username and domain
    return maskedUsername + '@' + domain;
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
              key: _formKey, // Assign the _formKey here
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
                          autofocus: index == 0, // Autofocus on the first input
                          decoration: const InputDecoration(
                            counter: Offstage(), // Hides character counter
                            contentPadding: EdgeInsets.all(10), // Adjust padding
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
                              // Shift focus to the next input field
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
                          onPressed: () {
                            // Implement resend functionality
                            // Reset the timer
                            setState(() {
                              _start = 120;
                            });
                            // Restart the timer
                            startTimer();
                          },
                          child: const Text('Resend OTP',
                            style: TextStyle(
                              fontFamily: "SansSerif",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 30, 58, 58),
                            ),
                          ),
                        )
                      : Text('Resend OTP in ${formatTimer(_start)}',
                          style: const TextStyle(
                            fontFamily: "SansSerif",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 30, 58, 58),
                          ),
                      ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Validate form and submit if valid
                      if (_formKey.currentState!.validate()) {
                        // Handle OTP submission
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Reset Password',
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
