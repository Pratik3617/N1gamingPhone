import 'package:flutter/material.dart';
import 'package:n1gaming/Home/Drawer.dart';
import 'package:n1gaming/Home/HomeBottom.dart';
import 'package:n1gaming/Home/HomeHeader.dart';
import 'package:n1gaming/Home/HomeLeft.dart';
import 'package:n1gaming/Home/HomeMiddle.dart';
import 'package:n1gaming/Home/HomeRight.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  int GrandTotal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 58, 58),
      
      drawer: DrawerWidget(),

      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align widgets to the start of the column
          children: [
            HomeHeader(),
            const SizedBox(height: 2), // Add some space between the widgets
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeLeft(),
                Consumer<GameSelector>(
                  builder: (context, value, child) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width*0.72,
                        child: HomeMiddle(
                          rowControllers: Provider.of<GameSelector>(context).rowControllers,
                          columnControllers: Provider.of<GameSelector>(context).columnControllers,
                          matrixControllers: value.controllers,
                          context: context,
                        ),
                    );
                  },
                ),
                Consumer<GameSelector>(builder: (context, value, child) {
                  return HomeRight(
                      controllers: value.controllers,
                      context: context,
                      onGrandTotalChange: (newValue) {
                        GrandTotal = newValue;
                      });
                }),
              ],
            ),

            HomeBottom(),
          ],
        ),
      ),

    );
  }
}
