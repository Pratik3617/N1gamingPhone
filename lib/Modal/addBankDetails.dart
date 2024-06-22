// ignore_for_file: prefer_final_fields, use_build_context_synchronously, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n1gaming/API/Home/addBankDetailsAPI.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/successModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addBankDetails extends StatefulWidget {
  const addBankDetails({super.key});

  @override
  addBankDetailsState createState() => addBankDetailsState();
}

class addBankDetailsState extends State<addBankDetails> {
  TextEditingController accountNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController upiId = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? token;
  String message= "";

  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  Future<int> addBank() async{
    var response = await addBankDetailsAPI(accountNumber.text,name.text, ifscCode.text,upiId.text,token!);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      message = responseBody['message'];
    } else {
      message = responseBody['message'];
    }
    accountNumber.text="";
    name.text="";
    upiId.text="";
    ifscCode.text="";
    
    return response.statusCode;
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    name.dispose();
    upiId.dispose();
    ifscCode.dispose();
    accountNumber.dispose();
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
        height: MediaQuery.of(context).size.height * 0.95,
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text("Add bank Details",
              textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 58, 58),
                  ),
              ),
              Form(
                key: _formKey, // Assigning the _formKey here
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Account holder name',
                        suffixIcon: Icon(Icons.person)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: accountNumber,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Account Number',
                        suffixIcon: Icon(Icons.lock)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: upiId,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'UPI Id',
                        suffixIcon: Icon(Icons.account_box)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (!value.contains('@')) {
                          return 'Please enter valid UPI Id';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: ifscCode,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'IFSC code',
                        suffixIcon: Icon(Icons.code)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter IFSC code';
                        } 
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    int statusCode = await addBank();
                    hideLoadingDialog(context);
                    if(statusCode == 200){
                      Navigator.of(context).pop();
                      showSuccessDialog(context, message);
                    }else{
                      Navigator.of(context).pop();
                      showErrorDialog(context, message);
                    }
                  }
                },
                style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 30, 58, 58)),
                    ),
                
                child: const Text(
                  'SUBMIT',
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
