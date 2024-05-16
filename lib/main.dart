import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:n1gaming/Login/Login.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:n1gaming/Provider/ResultProvider.dart';
import 'package:n1gaming/Provider/TransactionProvider.dart';
import 'package:n1gaming/Result/Result.dart';
import 'package:n1gaming/Transaction/Transaction.dart';
import 'package:provider/provider.dart';

import "Home/Home.dart";

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => UserProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => AccountDetailsProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => GameSelector()
        ),

        ChangeNotifierProvider(
          create: (context) => ShowResultProvider()
        ),

        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   textTheme: const TextTheme(
        //     bodyText2: customTextStyle,
        //   ),
        // ),
        home:  Home(),
        routes: {
          '/result': (_) => Result(),
          // '/accounts': (_) => Accounts(),
          '/home': (_) =>  Home(),
          // '/transaction': (_) => Transaction(),
          // '/cancelReprint': (_) => CancelReprint(),
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Home()
    );
  }
}


