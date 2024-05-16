import 'package:flutter/material.dart';
import 'package:n1gaming/Home/ChangePassword.dart';
import 'package:n1gaming/Login/Login.dart';
import 'package:n1gaming/Result/Result.dart';
import 'package:n1gaming/Transaction/Transaction.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.33,
      child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.20, // Adjust the height as needed
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 30, 58, 58),
            ),
            child:const Center(
              child: Text(
                'Prateek',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_outlined, // Choose your desired icon
              color: Color.fromARGB(255, 30, 58, 58), // Icon color
            ),
            title: const Text(
              'Transaction List',
              style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Transaction(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined, // Choose your desired icon
              color: Color.fromARGB(255, 30, 58, 58), // Icon color
            ),
            title: const Text(
              'Result',
              style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Result(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, // Choose your desired icon
              color: Color.fromARGB(255, 30, 58, 58), // Icon color
            ),
            title: const Text(
              'Change Password',
              style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),
            ),
            onTap: () {
              showDialog(context: context, 
                builder: (BuildContext context) {
                  return const ChangePassModal();
                }
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.lock_outline, // Choose your desired icon
              color: Color.fromARGB(255, 30, 58, 58), // Icon color
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),
            ),
            onTap: () {
              
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const LoginPage(),
                  ),
                );
            },
          ),
        ],
      ),
    ),
    );
  }
}
