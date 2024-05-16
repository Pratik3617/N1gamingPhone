import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeHeader extends StatefulWidget {
  String nextGame;
  String timeLeft;
  HomeHeader(
    {super.key,
    required this.nextGame,
    required this.timeLeft,
    }
  );


  @override
  HomeHeaderState createState() => HomeHeaderState();
}

class HomeHeaderState extends State<HomeHeader>{

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.985,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Next Game: ${widget.nextGame}",style: const TextStyle(
                      fontFamily: 'SansSerif',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.amber
                    ),),
                  ],
                ),
                const SizedBox(width: 30), // Add spacing between text widgets
                // const Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text("Balance: Rs 2000",style: TextStyle(
                //       fontFamily: 'SansSerif',
                //       fontSize: 16.0,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 1,
                //       color: Colors.amber
                //     ),),
                //   ],
                // ),
              ],
            ),
            const Row(
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
                Text("Time Left: ${widget.timeLeft}",style: const TextStyle(
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
