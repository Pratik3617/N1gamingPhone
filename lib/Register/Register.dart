import 'package:flutter/material.dart';
import 'package:n1gaming/Login/LoginLeft.dart';
import 'package:n1gaming/Login/LoginRight.dart';
import 'package:n1gaming/Register/RegisterLeft.dart';
import 'package:n1gaming/Register/RegisterRight.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 58, 58),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegisterLeftContent(),

                RegisterRightContent(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
