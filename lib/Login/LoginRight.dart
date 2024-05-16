import 'package:flutter/material.dart';
import 'package:n1gaming/Home/Home.dart';
import 'package:n1gaming/Login/ForgotPassModal.dart';
import 'package:n1gaming/Register/Register.dart';

class RightContent extends StatefulWidget {
  const RightContent({Key? key});

  @override
  _RightContentState createState() => _RightContentState();
}

class _RightContentState extends State<RightContent> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to validate both email and password
  bool _validateInputs() {
    if (_formKey.currentState!.validate()) {
      // Both email and password are valid
      return true;
    } else {
      // Either email or password is invalid
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                onPressed: () {
                  if (_validateInputs()) {
                    // Perform login here
                    // print(_emailController.text);
                    // print(_passwordController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
                  // else {
                  //   // Show error dialog
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text('Error'),
                  //         content: Text('Please fill out all fields correctly.'),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //             child: Text('OK'),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
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
                  // Add registration functionality here
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
    );
  }
}

