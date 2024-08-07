import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n1gaming/API/Home/getQR.dart';
import 'package:n1gaming/API/Home/showTransactionAPI.dart';
import 'package:n1gaming/API/Login/getWalletAPI.dart';
import 'package:n1gaming/API/Login/logoutAPI.dart';
import 'package:n1gaming/API/Result/resultAPI.dart';
import 'package:n1gaming/Account/account.dart';
import 'package:n1gaming/Modal/ChangePassword.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/addBankDetails.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/qrImage.dart';
import 'package:n1gaming/Modal/withdrawMoney.dart';
import 'package:n1gaming/Login/Login.dart';
import 'package:n1gaming/Provider/ResultProvider.dart';
import 'package:n1gaming/Provider/TransactionProvider.dart';
import 'package:n1gaming/Provider/accountsProvider.dart';
import 'package:n1gaming/Result/Result.dart';
import 'package:n1gaming/Transaction/Transaction.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key}) : super(key: key);
  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  String? username;
  int? balance;
  String qrMessage = "";
  String path = "";
  String upi = "";
  final String baseUrl = 'https://n1gaming-backend-app.onrender.com';

  @override
  void initState() {
    super.initState();
    getUsername();
    getBalance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  void userLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', "");
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Future<int> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await logoutAPI(token!);
    return response.statusCode;
  }

  void getBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getInt('walletBalance');
    });
  }

  List<dynamic> convertTimeFormat(List<dynamic> localDataList) {
    for (int i = 0; i < localDataList.length; i++) {
      String originalTime = localDataList[i][0].toString();

      DateTime parsedTime = DateFormat('HH:mm:ss').parse(originalTime);

      String formattedTime = DateFormat('hh:mm a').format(parsedTime);

      localDataList[i][0] = formattedTime;
    }
    return localDataList;
  }

  Future<void> _TodayResult() async {
    try {
      DateTime today = DateTime.now();
      DateTime currentDate = DateTime(today.year, today.month, today.day);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      final response = await fetchResult(token!, currentDate);
      if (response.containsKey('error')) {
        context.read<ShowResultProvider>().updateResult([]);
      } else {
        List<dynamic> localDataList = response['result'];
        List<dynamic> updatedDataList = convertTimeFormat(localDataList);

        context.read<ShowResultProvider>().updateResult(updatedDataList);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(),
        ),
      );
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  Future<void> getUserBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    showLoadingDialog(context);
    await fetchBalance(token!);
    getBalance();
    hideLoadingDialog(context);
  }

  Future<int> getQRDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await getQR(token!);
    var responseBody = json.decode(response.body);
    print(responseBody);

    if (response.statusCode == 200) {
      path = baseUrl + responseBody['image'];
      upi = responseBody['upi_id'];
    } else {
      qrMessage = responseBody['message'];
    }
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.36,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.16, // Adjust the height as needed
              color: const Color.fromARGB(255, 30, 58, 58),
              child: Center(
                child: Text(
                  "${username?.toUpperCase()}",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.wallet_sharp, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: Text(
                      'Wallet Balance: $balance ₹',
                      style: const TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () async {
                      await getUserBalance();
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.qr_code, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Recharge',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () async {
                      showLoadingDialog(context);
                      int statusCode = await getQRDetails();
                      hideLoadingDialog(context);
                      if (statusCode == 200) {
                        qrDialog(context, path, upi);
                      } else {
                        showErrorDialog(context, qrMessage);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.list_alt_outlined, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Transaction List',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () async {
                      showLoadingDialog(context);

                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      var token = prefs.getString('token');
                      TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
                      await fetchTransactionAPI(token!, transactionProvider);
                      hideLoadingDialog(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Transaction(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.history, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Account History',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      var token = prefs.getString('token');
                      Provider.of<AccountHistoryProvider>(context, listen: false)
                          .fetchAccountHistory(token!);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Account(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.library_books_outlined, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Result',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () {
                      _TodayResult();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Result(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.add_card, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Add Bank Details',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const addBankDetails();
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.money_off_outlined, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Withdraw Money',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const withdrawMoney();
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.account_circle, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ChangePassModal();
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.lock_outline, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'SansSerif',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color.fromARGB(255, 30, 58, 58),
                      ),
                    ),
                    onTap: () async {
                      showLoadingDialog(context);
                      int statuscode = await logout();
                      hideLoadingDialog(context);
                      if (statuscode == 200) {
                        userLogout();
                      }
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.help_rounded, // Choose your desired icon
                      color: Color.fromARGB(255, 30, 58, 58), // Icon color
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Contact",
                        style: TextStyle(
                          fontFamily: 'SansSerif',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Color.fromARGB(255, 30, 58, 58),
                        ),
                      ),

                      Text("support@n1gaming.in",
                        style: TextStyle(
                          fontFamily: 'SansSerif',
                          fontSize: 14.0,
                          letterSpacing: 1,
                          color: Color.fromARGB(255, 30, 58, 58),
                        ),
                      ),
                    ],),
                    onTap: (){
                      
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
