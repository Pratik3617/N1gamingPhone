import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.985,
        height: MediaQuery.of(context).size.height * 0.08,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Prateek",style: TextStyle(
                      fontFamily: 'SansSerif',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.amber
                    ),),
                  ],
                ),
                SizedBox(width: 30), // Add spacing between text widgets
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Balance: Rs 2000",style: TextStyle(
                      fontFamily: 'SansSerif',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.amber
                    ),),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("N.1 Gaming",style: TextStyle(
                  fontFamily: 'Poppins',
                      fontSize: 18.0,
                      letterSpacing: 1,
                      color: Colors.white
                    ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Time Left: 14:05:02",style: TextStyle(
                  fontFamily: 'SansSerif',
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber
                    ),),
              ],
            ),
          ],
        ),
      );
  }

}
