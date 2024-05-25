// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, library_private_types_in_public_api, avoid_print
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n1gaming/API/Result/resultAPI.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Provider/ResultProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultDateForm extends StatefulWidget {
  const ResultDateForm({super.key});

  @override
  _DateInputFormState createState() => _DateInputFormState();
}

class _DateInputFormState extends State<ResultDateForm> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
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

  

  @override
  Widget build(BuildContext context) {

  Future<void> submitForm(BuildContext context) async {
    if (_selectedDate != null) {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        showLoadingDialog(context);
        final response = await fetchResult(token!, _selectedDate!);
        hideLoadingDialog(context);
        if (response.containsKey('error')) {
          context.read<ShowResultProvider>().updateResult([]);
        } else {
          List<dynamic> localDataList = response['result'];
          List<dynamic> updatedDataList = convertTimeFormat(localDataList);
          context.read<ShowResultProvider>().updateResult(updatedDataList);
        }
      } catch (e) {
        print('Failed to fetch data: $e');
      }
    } else {
      print('No date selected');
    }
  }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          TextFormField(
            controller: _dateController,
            readOnly: true,
            onTap: () => selectDate(context),
            decoration: InputDecoration(
              labelText: 'Select Date',
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
            ),
            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.height*0.035),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02),

          ElevatedButton(
            onPressed: () => submitForm(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Select Date',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height*0.038,
                  fontFamily: 'SanSerif',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }
}
