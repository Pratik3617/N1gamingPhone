import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 58, 58),
              ),
              child: Text(
                'N.1 Gaming',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Account',style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),),
              onTap: () {
                // Implement item 1 functionality here
              },
            ),
            ListTile(
              title: const Text('Transaction List',style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),),
              onTap: () {
                // Implement item 2 functionality here
              },
            ),
            ListTile(
              title: const Text('Result',style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),),
              onTap: () {
                // Implement item 2 functionality here
              },
            ),
            
            ListTile(
              title: const Text('Reset All',style: TextStyle(
                fontFamily: 'SansSerif',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color.fromARGB(255, 30, 58, 58),
              ),),
              onTap: () {
                // Implement item 2 functionality here
              },
            ),
          ],
        ),
      );
  }

}
