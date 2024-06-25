import 'package:flutter/material.dart';
import 'package:n1gaming/Home/Drawer.dart';
import 'package:flutter/services.dart';
import 'package:n1gaming/Home/HomeBottom.dart';
import 'package:n1gaming/Home/HomeHeader.dart';
import 'package:n1gaming/Home/HomeLeft.dart';
import 'package:n1gaming/Home/HomeMiddle.dart';
import 'package:n1gaming/Home/HomeRight.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';
import 'dart:async';



class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  HomeWidget createState() => HomeWidget();
}

class HomeWidget extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int grandTotal = 0;
  late Timer _timer1;
  late Timer _timer2;
  DateTime _currentTime = DateTime.now();



  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _startTimer();
  }

  @override
  void dispose() {
    _timer1.cancel();
    _timer2.cancel();
    super.dispose();
  }

   void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  List<String> times = [
    "09:30:00 AM","09:40:00 AM","09:50:00 AM","10:00:00 AM",
    "10:10:00 AM","10:20:00 AM","10:30:00 AM","10:40:00 AM","10:50:00 AM","11:00:00 AM",
    "11:10:00 AM","11:20:00 AM","11:30:00 AM","11:40:00 AM","11:50:00 AM","12:00:00 PM",
    "12:10:00 PM","12:20:00 PM","12:30:00 PM","12:40:00 PM","12:50:00 PM","01:00:00 PM",
    "01:10:00 PM","01:20:00 PM","01:30:00 PM","01:40:00 PM","01:50:00 PM","02:00:00 PM",
    "02:10:00 PM","02:20:00 PM","02:30:00 PM","02:40:00 PM","02:50:00 PM","03:00:00 PM",
    "03:10:00 PM","03:20:00 PM","03:30:00 PM","03:40:00 PM","03:50:00 PM","04:00:00 PM",
    "04:10:00 PM","04:20:00 PM","04:30:00 PM","04:40:00 PM","04:50:00 PM","05:00:00 PM",
    "05:10:00 PM","05:20:00 PM","05:30:00 PM","05:40:00 PM","05:50:00 PM","06:00:00 PM",
    "06:10:00 PM","06:20:00 PM","06:30:00 PM","06:40:00 PM","06:50:00 PM","07:00:00 PM",
    "07:10:00 PM","07:20:00 PM","07:30:00 PM","07:40:00 PM","07:50:00 PM","08:00:00 PM",
    "08:10:00 PM","08:20:00 PM","08:30:00 PM","08:40:00 PM","08:50:00 PM","09:00:00 PM",
    "09:10:00 PM","09:20:00 PM","09:30:00 PM","09:40:00 PM","09:50:00 PM","10:00:00 PM",
    "10:10:00 PM","10:20:00 PM","10:30:00 PM","10:40:00 PM","10:50:00 PM","11:00:00 PM"
  ];

  int _currentIndex = 0;

  void _startTimer() {
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        int hours = _currentTime.hour;
        int min = _currentTime.minute;

        while (_currentIndex < times.length - 1) {
          int h = int.parse(times[_currentIndex].substring(0, 2));
          int m = int.parse(times[_currentIndex].substring(3, 5));
          if (times[_currentIndex].substring(9, 11) != "AM") {
            if (times[_currentIndex].substring(0, 2) != "12") {
              h = h + 12;
            }
          }
          if (h == hours) {
            if (m > min) {
              break;
            }
          } else if (h > hours) {
            break;
          }
          _currentIndex++;
        }
        if (_currentTime.hour >= 22 ) {
          _currentIndex = 0;
        }
      });
    });
  }
  
  String? timeToNextMultipleOf10(DateTime currentTime) {
    if (((currentTime.hour == 9 && currentTime.minute>=20) || (currentTime.hour >=10) )&& currentTime.hour < 23) {
      int minutes = currentTime.minute;
      int seconds = currentTime.second;
      int minutesUntilNextMultipleOf10 = 9 - (minutes % 10);
      int secondsUntilNextMultipleOf10 = 60 - seconds;
      
      int totalTimeInSeconds = (minutesUntilNextMultipleOf10 * 60) + secondsUntilNextMultipleOf10;
      // time = totalTimeInSeconds;
      int minutesLeft = totalTimeInSeconds ~/ 60;
      int secondsLeft = totalTimeInSeconds % 60;
      
      String formattedMinutes = minutesLeft.toString().padLeft(2, '0');
      String formattedSeconds = secondsLeft.toString().padLeft(2, '0');
      
      return '00:$formattedMinutes:$formattedSeconds';
    } else {
      return null;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    
    // Calculate time until the next multiple of 10
    String? timeLeft = timeToNextMultipleOf10(currentTime);


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 30, 58, 58),
      
      drawer: DrawerWidget(),

      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            HomeHeader(nextGame: times[_currentIndex],timeLeft: timeLeft ?? "--:--:--",openDrawer: _openDrawer,),
            
            const SizedBox(height: 2),
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
                        grandTotal = newValue;
                        value.grandTotal = newValue;
                      });
                }),
              ],
            ),

            HomeBottom(nextGame: times[_currentIndex],),
            
          ],
        ),
      ),

    );
  }
}
