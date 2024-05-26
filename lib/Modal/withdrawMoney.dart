// ignore_for_file: prefer_final_fields, use_build_context_synchronously, camel_case_types

import 'package:flutter/material.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class withdrawMoney extends StatefulWidget {
  const withdrawMoney({super.key});

  @override
  withdrawMoneyState createState() => withdrawMoneyState();
}

class withdrawMoneyState extends State<withdrawMoney> {
  TextEditingController amount = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? token;
  String changePassError= "";

  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  // Future<int> changeUserPassword() async{
  //   var response = await changePassword(_currentPassword.text,_newPassword.text,token!);
  //   var responseBody = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     changePassError = responseBody['message'];
  //   } else {
  //     changePassError = responseBody['message'];
  //   }
  //   _currentPassword.text="";
  //   _newPassword.text="";
  //   _confirmPassword.text="";
    
  //   return response.statusCode;
  // }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero, // Remove padding around the dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text("Enter Amount",
              textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 58, 58),
                    letterSpacing: 1
                  ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey, // Assigning the _formKey here
                child: Column(
                  children: [
                    TextFormField(
                      controller: amount,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter amount',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    // int statusCode = await changeUserPassword();
                    hideLoadingDialog(context);
                    
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 30, 58, 58)),
                ),
                
                child: const Text(
                  'WITHDRAW MONEY',
                  style: TextStyle(
                    fontFamily: "YoungSerif",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
