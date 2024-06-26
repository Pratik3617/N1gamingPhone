import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:n1gaming/Connectivity/controller.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:n1gaming/Provider/ResultProvider.dart';
import 'package:n1gaming/Provider/TransactionProvider.dart';
import 'package:n1gaming/Provider/accountsProvider.dart';
import 'package:n1gaming/Result/Result.dart';
import 'package:provider/provider.dart';

import 'Home/Home.dart';
import 'splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameSelector(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowResultProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountHistoryProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );

  Get.put(InternetController(),permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/result': (_) => Result(),
        '/home': (_) => Home(),
      },
    );
  }
}
