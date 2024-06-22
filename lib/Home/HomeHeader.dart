// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  String nextGame;
  String timeLeft;
  final VoidCallback openDrawer;

  HomeHeader({
    Key? key,
    required this.nextGame,
    required this.timeLeft,
    required this.openDrawer,
  }) : super(key: key);

  @override
  HomeHeaderState createState() => HomeHeaderState();
}

class HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.985,
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, -10), // Adjust the vertical offset as needed
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.amber),
                  onPressed: widget.openDrawer,
                  iconSize: 35,
                ),
              ),
              const SizedBox(width: 10), // Add spacing between icon and text
              Text(
                "Next Game: ${widget.nextGame}",
                style: const TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const Text(
            "N.1 Gaming",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.0,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
          Text(
            "Time Left: ${widget.timeLeft}",
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 16.0,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
