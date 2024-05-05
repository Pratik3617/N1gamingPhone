import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final String content;

  PageWidget({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.072,
      height: MediaQuery.of(context).size.height * 0.06,
      padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Center(
        child: Text(
        content,
        style: const TextStyle(
          fontFamily: 'SansSerif',
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 30, 58, 58),
        ),
      ),
      )
    );
  }
}
