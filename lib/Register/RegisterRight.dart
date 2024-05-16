// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:n1gaming/Login/Login.dart';

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
                onPressed: () {
                  if (_validateInputs()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
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
