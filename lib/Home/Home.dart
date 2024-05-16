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
  int grandTotal = 0;
  late Timer _timer1;
  late Timer _timer2;
  DateTime _currentTime = DateTime.now();
  String _remainingTime = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _startTimer();
    // initial();
  }

  @override
  void dispose() {
    _timer1?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  List<String> times = [
    "09:30:00 AM","09:45:00 AM","10:00:00 AM",
    "10:15:00 AM","10:30:00 AM","10:45:00 AM","11:00:00 AM","11:15:00 AM","11:30:00 AM","11:45:00 AM","12:00:00 PM",
    "12:15:00 PM","12:30:00 PM","12:45:00 PM","01:00:00 PM","01:15:00 PM","01:30:00 PM","01:45:00 PM","02:00:00 PM",
    "02:15:00 PM","02:30:00 PM","02:45:00 PM","03:00:00 PM","03:15:00 PM","03:30:00 PM","03:45:00 PM","04:00:00 PM",
    "04:15:00 PM","04:30:00 PM","04:45:00 PM","05:00:00 PM","05:15:00 PM","05:30:00 PM","05:45:00 PM","06:00:00 PM",
    "06:15:00 PM","06:30:00 PM","06:45:00 PM","07:00:00 PM","07:15:00 PM","07:30:00 PM","07:45:00 PM","08:00:00 PM",
    "08:15:00 PM","08:30:00 PM","08:45:00 PM","09:00:00 PM","09:15:00 PM","09:30:00 PM","09:45:00 PM","10:00:00 PM"
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
        if (_currentTime.hour >= 22) {
          _currentIndex = 0;
        }
      });
    });
  }


  
  String? timeToNextMultipleOf15(DateTime currentTime) {
    // Check if the current time is within the range of 9:15 AM to 10:15 PM
    if (currentTime.hour >= 9 && currentTime.hour < 22) {
      // Calculate minutes and seconds remaining until the next multiple of 15
      int minutes = currentTime.minute;
      int seconds = currentTime.second;
      int minutesUntilNextMultipleOf15 = 14 - (minutes % 15);
      int secondsUntilNextMultipleOf15 = 60 - seconds;
      
      // Calculate the total time left in seconds
      int totalTimeInSeconds = (minutesUntilNextMultipleOf15 * 60) + secondsUntilNextMultipleOf15;
      
      // Convert the total time left to minutes and seconds format
      int minutesLeft = totalTimeInSeconds ~/ 60;
      int secondsLeft = totalTimeInSeconds % 60;
      
      // Add padding to minutes and seconds if they are single-digit numbers
      String formattedMinutes = minutesLeft.toString().padLeft(2, '0');
      String formattedSeconds = secondsLeft.toString().padLeft(2, '0');
      
      return '00:$formattedMinutes:$formattedSeconds';
    } else {
      // If the current time is outside the specified range, return null
      return null;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    
    // Calculate time until the next multiple of 15
    String? timeLeft = timeToNextMultipleOf15(currentTime);


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 58, 58),
      
      drawer: const DrawerWidget(),

      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            HomeHeader(nextGame: times[_currentIndex],timeLeft: timeLeft ?? "--:--:--",),
            
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

            const HomeBottom(),
            
          ],
        ),
      ),

    );
  }
}
