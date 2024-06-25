// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/successModal.dart';
import 'package:provider/provider.dart';

Dialog buildPrintDialog({
  required BuildContext context,
  required String userName,
  required String txnId,
  required String slipDate,
  required String selectedTimes,
  required List<String> selectedCharacters,
  required int totalPoints,
  required int countTimeSlots,
  required dynamic body,
}) {
  List<DateTime> parseTimeSlots(String timeSlotsString) {
    DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");
    return timeSlotsString
        .split(',')
        .where((timeSlot) => timeSlot.isNotEmpty)
        .map((timeSlot) => format.parse(timeSlot.trim()))
        .toList();
  }

  bool isTimeSlotInPast(DateTime timeSlot) {
    DateTime now = DateTime.now();
    return timeSlot.isBefore(now);
  }

  
  Future<void> processPlayAction(BuildContext context) async {
    showLoadingDialog(context);

    Map<String, dynamic> response = await Provider.of<GameSelector>(context, listen: false).postGameData(body);

    int statusCode = response['statusCode'];
    String message = response['message'];

    hideLoadingDialog(context);

    if (statusCode == 201) {
      // Success, you can proceed with your login
      Navigator.of(context).pop();
      Provider.of<GameSelector>(context, listen: false).resetMatrixData();
      Provider.of<GameSelector>(context, listen: false).resetRowColumnsControllers();
      Provider.of<GameSelector>(context, listen: false).resetControllers();
      Provider.of<GameSelector>(context, listen: false).resetTimes();
      Provider.of<GameSelector>(context, listen: false).resetCheckBox();
      showSuccessDialog(context, message);
    } else {
      Navigator.of(context).pop();
      showErrorDialog(context, message);
    }
  }

  void checkTimeSlots(BuildContext context) {
    List<DateTime> timeSlots = parseTimeSlots(selectedTimes);
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    for (DateTime timeSlot in timeSlots) {
      if (dateFormat.format(timeSlot) == dateFormat.format(now) && isTimeSlotInPast(timeSlot)) {
        showErrorDialog(context, "Error: Selected time ${DateFormat('hh:mm a').format(timeSlot)} is in the past.");
        return;
      }
    }

    processPlayAction(context);
  }


  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    backgroundColor: Colors.white,
    child: Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepaintBoundary(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "N.1 GAMING",
                      style: TextStyle(
                        fontFamily: 'YoungSerif',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "FOR AMUSEMENT ONLY",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userName.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "ID : $txnId",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Slip DT : $slipDate",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Game Date : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      selectedTimes,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      selectedCharacters.join(" "),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Quantity : $totalPoints    Points : $totalPoints",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Total Quantity : ${totalPoints * countTimeSlots}   Total Points : ${totalPoints * countTimeSlots}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                          fontFamily: "SansSerif",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: "SansSerif",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () => checkTimeSlots(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.yellow, width: 2.0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                          fontFamily: "SansSerif",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Play",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: "SansSerif",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


