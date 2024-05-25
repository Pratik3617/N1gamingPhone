// ignore_for_file: constant_identifier_names, unused_field
// import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeState {
  bool active;
  bool selected;

  TimeState({required this.active, required this.selected});
}

class GameSelector with ChangeNotifier {
  TextEditingController barcodeController = TextEditingController(text: "");
  late Timer _timer5;
  GameSelector() {
    setRandomForLP();
    _timer5 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setTimeCheckBoxesState();
    });
  }

  Future<Map<String, dynamic>> postGameData(dynamic body) async {
    
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      
      var headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      
      String jsonBody = jsonEncode(body);

      http.Response response = await http.post(
        Uri.parse("https://n1gaming-backend-app.onrender.com/transaction/"),
        headers: headers,
        body: jsonBody
      );
      final responseBody = jsonDecode(response.body);
      print(responseBody);

      return {
        'statusCode': response.statusCode,
        'message': responseBody['message']
      };

    } catch (e) {
      String errorMessage;
      if (e is http.ClientException) {
        errorMessage = "ClientException: ${e.message}";
      } else if (e is FormatException) {
        errorMessage = "FormatException: ${e.message}";
      } else {
        errorMessage = "Unexpected error: $e";
      }


      return {
        'statusCode': -1, // Or any other code to indicate an error
        'message': errorMessage
      };
    }
  }

  setTimeCheckBoxesState() async {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateTime tomorrowTime =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0, 0);

    for (var time in times) {
      if (isTimePassed(time, showNextDayTimes ? tomorrowTime : now)) {
        timesValues[time]!.active = false;
        timesValues[time]!.selected = false;
      } else {
        timesValues[time]!.active = true;
      }
    }
    notifyListeners();
  }

  String activeMatrix = 'A';
  String prevActiveMatrix = 'A';

  bool? selectedToday;
  bool showNextDayTimes = false;
  bool showTimes = false;
  bool allTimesSelected = false;

  Map<String, bool> checkBoxValues = {
    'A': true,
    'B': false,
    'C': false,
    'D': false,
    'E': false,
    'F': false,
    'G': false,
    'H': false,
    'I': false,
    'J': false,
    'K': false,
    'L': false,
    'M': false,
    'N': false,
    'O': false,
    'P': false,
    'Q': false,
    'R': false,
    'S': false,
    'T': false,
  };

  List<String> checkbox = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T"
  ];

  Map<String, TimeState> timesValues = {
    "09:30 AM": TimeState(active: true, selected: false),
    "09:45 AM": TimeState(active: true, selected: false),
    "10:00 AM": TimeState(active: true, selected: false),
    "10:15 AM": TimeState(active: true, selected: false),
    "10:30 AM": TimeState(active: true, selected: false),
    "10:45 AM": TimeState(active: true, selected: false),
    "11:00 AM": TimeState(active: true, selected: false),
    "11:15 AM": TimeState(active: true, selected: false),
    "11:30 AM": TimeState(active: true, selected: false),
    "11:45 AM": TimeState(active: true, selected: false),
    "12:00 PM": TimeState(active: true, selected: false),
    "12:15 PM": TimeState(active: true, selected: false),
    "12:30 PM": TimeState(active: true, selected: false),
    "12:45 PM": TimeState(active: true, selected: false),
    "01:00 PM": TimeState(active: true, selected: false),
    "01:15 PM": TimeState(active: true, selected: false),
    "01:30 PM": TimeState(active: true, selected: false),
    "01:45 PM": TimeState(active: true, selected: false),
    "02:00 PM": TimeState(active: true, selected: false),
    "02:15 PM": TimeState(active: true, selected: false),
    "02:30 PM": TimeState(active: true, selected: false),
    "02:45 PM": TimeState(active: true, selected: false),
    "03:00 PM": TimeState(active: true, selected: false),
    "03:15 PM": TimeState(active: true, selected: false),
    "03:30 PM": TimeState(active: true, selected: false),
    "03:45 PM": TimeState(active: true, selected: false),
    "04:00 PM": TimeState(active: true, selected: false),
    "04:15 PM": TimeState(active: true, selected: false),
    "04:30 PM": TimeState(active: true, selected: false),
    "04:45 PM": TimeState(active: true, selected: false),
    "05:00 PM": TimeState(active: true, selected: false),
    "05:15 PM": TimeState(active: true, selected: false),
    "05:30 PM": TimeState(active: true, selected: false),
    "05:45 PM": TimeState(active: true, selected: false),
    "06:00 PM": TimeState(active: true, selected: false),
    "06:15 PM": TimeState(active: true, selected: false),
    "06:30 PM": TimeState(active: true, selected: false),
    "06:45 PM": TimeState(active: true, selected: false),
    "07:00 PM": TimeState(active: true, selected: false),
    "07:15 PM": TimeState(active: true, selected: false),
    "07:30 PM": TimeState(active: true, selected: false),
    "07:45 PM": TimeState(active: true, selected: false),
    "08:00 PM": TimeState(active: true, selected: false),
    "08:15 PM": TimeState(active: true, selected: false),
    "08:30 PM": TimeState(active: true, selected: false),
    "08:45 PM": TimeState(active: true, selected: false),
    "09:00 PM": TimeState(active: true, selected: false),
    "09:15 PM": TimeState(active: true, selected: false),
    "09:30 PM": TimeState(active: true, selected: false),
    "09:45 PM": TimeState(active: true, selected: false),
    "10:00 PM": TimeState(active: true, selected: false)
  };

  List<String> times = [
    "09:30 AM",
    "09:45 AM",
    "10:00 AM",
    "10:15 AM",
    "10:30 AM",
    "10:45 AM",
    "11:00 AM",
    "11:15 AM",
    "11:30 AM",
    "11:45 AM",
    "12:00 PM",
    "12:15 PM",
    "12:30 PM",
    "12:45 PM",
    "01:00 PM",
    "01:15 PM",
    "01:30 PM",
    "01:45 PM",
    "02:00 PM",
    "02:15 PM",
    "02:30 PM",
    "02:45 PM",
    "03:00 PM",
    "03:15 PM",
    "03:30 PM",
    "03:45 PM",
    "04:00 PM",
    "04:15 PM",
    "04:30 PM",
    "04:45 PM",
    "05:00 PM",
    "05:15 PM",
    "05:30 PM",
    "05:45 PM",
    "06:00 PM",
    "06:15 PM",
    "06:30 PM",
    "06:45 PM",
    "07:00 PM",
    "07:15 PM",
    "07:30 PM",
    "07:45 PM",
    "08:00 PM",
    "08:15 PM",
    "08:30 PM",
    "08:45 PM",
    "09:00 PM",
    "09:15 PM",
    "09:30 PM",
    "09:45 PM",
    "10:00 PM",
  ];

  bool isTimePassed(String inputTime, DateTime now) {
    // Parse the provided time string into DateTime object
    DateTime providedTime = DateFormat('hh:mm a').parse(inputTime);

    // Create a DateTime for today with the provided time
    DateTime todayWithProvidedTime = DateTime(
        now.year, now.month, now.day, providedTime.hour, providedTime.minute);

    // Compare if the calculated time has passed
    if (now.isAfter(todayWithProvidedTime)) {
      return true; // Time has passed for today
    } else {
      return false; // Time has not passed yet for today
    }
  }

  bool atIsChecked = false;
  bool ajIsChecked = false, ktIsChecked = false;
  bool allIsChecked = false, evenIsChecked = false, oddIsChecked = false;
  bool fpIsChecked = false;
  int selectedAlphabet = 0;

  List<List<TextEditingController>> controllers = List.generate(
      10, (i) => List.generate(10, (j) => TextEditingController()));

  List<List<TextEditingController>> get newControllers {
    return controllers;
  }

  int grandTotal = 0;

  TextEditingController lpController = TextEditingController();

  int r1 = 0;
  int r2 = 0;
  int r3 = 0;
  int r4 = 0;
  int r5 = 0;
  int r6 = 0;
  int r7 = 0;
  int r8 = 0;

  setRandomForLP() {
    r1 = getRandomNumber();
    r2 = getRandomNumber();
    r3 = getRandomNumber();
    r4 = getRandomNumber();
    r5 = getRandomNumber();
    r6 = getRandomNumber();
    r7 = getRandomNumber();
    r8 = getRandomNumber();
  }

  getRandomNumber() {
    Random rnd = Random();
    int min = 0;
    int max = 9;
    return min + rnd.nextInt(max - min);
  }

  performLP(String v) {
    controllers[r1][r2].text = v;
    controllers[r3][r4].text = v;
    controllers[r5][r6].text = v;
    controllers[r7][r8].text = v;
  }

  List<List<List<String?>>> matrixList = List.generate(
      20, (index) => List.generate(10, (i) => List.generate(10, (j) => "")));

  setCheckBoxes() {
    if (prevActiveMatrix.length == 1) {
      checkBoxValues[prevActiveMatrix] = true;
    } else if (prevActiveMatrix == "AT") {
      atIsChecked = true;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = true);
    } else if (prevActiveMatrix == "AJ") {
      ajIsChecked = true;
      checkBoxValues.forEach((k, v) {
        if (k == "A" ||
            k == "B" ||
            k == "C" ||
            k == "D" ||
            k == "E" ||
            k == "F" ||
            k == "G" ||
            k == "H" ||
            k == "I" ||
            k == "J") {
          checkBoxValues[k] = true;
        }
      });
    } else if (prevActiveMatrix == "KT") {
      ktIsChecked = true;
      checkBoxValues.forEach((k, v) {
        if (k == "K" ||
            k == "L" ||
            k == "M" ||
            k == "N" ||
            k == "O" ||
            k == "P" ||
            k == "Q" ||
            k == "R" ||
            k == "S" ||
            k == "T") {
          checkBoxValues[k] = true;
        }
      });
    }
  }

  SelectionType getSelectionType() {
    if (prevActiveMatrix.length == 1) {
      return SelectionType.SINGLE;
    } else if (prevActiveMatrix == "AT") {
      return SelectionType.ATOT;
    } else if (prevActiveMatrix == "AJ") {
      return SelectionType.ATOJ;
    } else if (prevActiveMatrix == "KT") {
      return SelectionType.KTOT;
    }
    return SelectionType.SINGLE;
  }

  void todayClicked() {
    for (var element in times) {
      timesValues[element]!.selected = false;
    }
    showTimes = true;
    selectedToday = true;
    showNextDayTimes = false;
    notifyListeners();
  }

  void nextDayClicked() {
    for (var element in times) {
      timesValues[element]!.selected = false;
    }
    showTimes = true;
    showNextDayTimes = true;
    selectedToday = null;
    notifyListeners();
  }

  void toggleAT(bool? value) {
    if (value == true) {
      prevActiveMatrix = activeMatrix;
      activeMatrix = "AT";
      atIsChecked = value!;
      ajIsChecked = !value;
      ktIsChecked = !value;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = true);
      handleMultipleCheckboxChange(value, SelectionType.ATOT);
    } else {
      // handleMultipleCheckboxChange(value!, getSelectionType());
      // checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // activeMatrix = prevActiveMatrix;
      // setCheckBoxes();
      // atIsChecked = value;
    }
    notifyListeners();
  }

  void toggleAJ(bool? value) {
    if (value == true) {
      prevActiveMatrix = activeMatrix;
      activeMatrix = "AJ";
      atIsChecked = !value!;
      ajIsChecked = value;
      ktIsChecked = !value;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      checkBoxValues.forEach((k, v) {
        if (k == "A" ||
            k == "B" ||
            k == "C" ||
            k == "D" ||
            k == "E" ||
            k == "F" ||
            k == "G" ||
            k == "H" ||
            k == "I" ||
            k == "J") {
          checkBoxValues[k] = true;
        }
      });
      handleMultipleCheckboxChange(value, SelectionType.ATOJ);
    } else {
      // handleMultipleCheckboxChange(value!, getSelectionType());
      // checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // activeMatrix = prevActiveMatrix;
      // setCheckBoxes();
      // ajIsChecked = value;
    }
    notifyListeners();
  }

  void toggleKT(bool? value) {
    if (value == true) {
      prevActiveMatrix = activeMatrix;
      activeMatrix = "KT";
      atIsChecked = !value!;
      ajIsChecked = !value;
      ktIsChecked = value;
      checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      checkBoxValues.forEach((k, v) {
        if (k == "K" ||
            k == "L" ||
            k == "M" ||
            k == "N" ||
            k == "O" ||
            k == "P" ||
            k == "Q" ||
            k == "R" ||
            k == "S" ||
            k == "T") {
          checkBoxValues[k] = true;
        }
      });
      handleMultipleCheckboxChange(value, SelectionType.KTOT);
    } else {
      // handleMultipleCheckboxChange(value!, getSelectionType());
      // checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
      // activeMatrix = prevActiveMatrix;
      // setCheckBoxes();
      // ktIsChecked = value;
    }
    notifyListeners();
  }

  void toggleAll(bool? value) {
    if (value == true) {
      allIsChecked = value!;
      evenIsChecked = !value;
      oddIsChecked = !value;
    } else {
      allIsChecked = value!;
    }
    notifyListeners();
  }

  void toggleEven(bool? value) {
    if (value == true) {
      allIsChecked = !value!;
      evenIsChecked = value;
      oddIsChecked = !value;
    } else {
      evenIsChecked = value!;
    }
    notifyListeners();
  }

  void toggleOdd(bool? value) {
    if (value == true) {
      allIsChecked = !value!;
      evenIsChecked = !value;
      oddIsChecked = value;
    } else {
      oddIsChecked = value!;
    }
    notifyListeners();
  }

  void toggleFP(bool? value) {
    fpIsChecked = value!;
    notifyListeners();
  }

  final List<TextEditingController> rowControllers =
      List.generate(10, (index) => TextEditingController());
  final List<TextEditingController> columnControllers =
      List.generate(10, (index) => TextEditingController());


  void handleCheckboxChange(String key, bool? value) {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        String? textValue = controllers[i][j].text;
        matrixList[selectedAlphabet][i][j] = textValue != "" ? textValue : "";
      }
    }

    // print("check box called");
    // Set all other checkboxes to false
    checkBoxValues.forEach((k, v) => checkBoxValues[k] = false);
    // Set the selected checkbox to true
    if (value != null) {
      checkBoxValues[key] = value;

      selectedAlphabet = checkbox.indexOf(key);

      for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
          controllers[i][j].text =
              matrixList[selectedAlphabet][i][j].toString();
        }
        rowControllers[i].text = "";
        columnControllers[i].text = "";
      }
    }

    notifyListeners();
  }

  void handleMultipleCheckboxChange(bool value, SelectionType type) {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        String? textValue = controllers[i][j].text;
        if (prevActiveMatrix.length == 1) {
          matrixList[checkbox.indexOf(prevActiveMatrix)][i][j] =
              textValue != "" ? textValue : "";
        } else if (prevActiveMatrix == "AT") {
          for (int k = 0; k < 20; k++) {
            matrixList[k][i][j] = textValue != "" ? textValue : "";
          }
        } else if (prevActiveMatrix == "AJ") {
          for (int k = 0; k < 10; k++) {
            matrixList[k][i][j] = textValue != "" ? textValue : "";
          }
        } else if (prevActiveMatrix == "KT") {
          for (int k = 10; k < 20; k++) {
            matrixList[k][i][j] = textValue != "" ? textValue : "";
          }
        }
      }
    }
    // if (value) {
    switch (type) {
      case SelectionType.SINGLE:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              controllers[i][j].text =
                  matrixList[checkbox.indexOf(prevActiveMatrix)][i][j]
                      .toString();
            }
          }
        }
        break;
      case SelectionType.ATOT:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              for (int k = 0; k < 20; k++) {
                controllers[i][j].text = matrixList[k][i][j].toString();
              }
            }
          }
        }
        break;
      case SelectionType.ATOJ:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              for (int k = 0; k < 10; k++) {
                controllers[i][j].text = matrixList[k][i][j].toString();
              }
            }
          }
        }
        break;
      case SelectionType.KTOT:
        {
          for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
              for (int k = 10; k < 20; k++) {
                controllers[i][j].text = matrixList[k][i][j].toString();
              }
            }
          }
        }
        break;
    }
    notifyListeners();
  }

  void resetTimes(){
    // selectedToday = true;
    showTimes = false;
    showNextDayTimes = false;
    selectedToday = null;

    timesValues = {
      "09:30 AM": TimeState(active: true, selected: false),
      "09:45 AM": TimeState(active: true, selected: false),
      "10:00 AM": TimeState(active: true, selected: false),
      "10:15 AM": TimeState(active: true, selected: false),
      "10:30 AM": TimeState(active: true, selected: false),
      "10:45 AM": TimeState(active: true, selected: false),
      "11:00 AM": TimeState(active: true, selected: false),
      "11:15 AM": TimeState(active: true, selected: false),
      "11:30 AM": TimeState(active: true, selected: false),
      "11:45 AM": TimeState(active: true, selected: false),
      "12:00 PM": TimeState(active: true, selected: false),
      "12:15 PM": TimeState(active: true, selected: false),
      "12:30 PM": TimeState(active: true, selected: false),
      "12:45 PM": TimeState(active: true, selected: false),
      "01:00 PM": TimeState(active: true, selected: false),
      "01:15 PM": TimeState(active: true, selected: false),
      "01:30 PM": TimeState(active: true, selected: false),
      "01:45 PM": TimeState(active: true, selected: false),
      "02:00 PM": TimeState(active: true, selected: false),
      "02:15 PM": TimeState(active: true, selected: false),
      "02:30 PM": TimeState(active: true, selected: false),
      "02:45 PM": TimeState(active: true, selected: false),
      "03:00 PM": TimeState(active: true, selected: false),
      "03:15 PM": TimeState(active: true, selected: false),
      "03:30 PM": TimeState(active: true, selected: false),
      "03:45 PM": TimeState(active: true, selected: false),
      "04:00 PM": TimeState(active: true, selected: false),
      "04:15 PM": TimeState(active: true, selected: false),
      "04:30 PM": TimeState(active: true, selected: false),
      "04:45 PM": TimeState(active: true, selected: false),
      "05:00 PM": TimeState(active: true, selected: false),
      "05:15 PM": TimeState(active: true, selected: false),
      "05:30 PM": TimeState(active: true, selected: false),
      "05:45 PM": TimeState(active: true, selected: false),
      "06:00 PM": TimeState(active: true, selected: false),
      "06:15 PM": TimeState(active: true, selected: false),
      "06:30 PM": TimeState(active: true, selected: false),
      "06:45 PM": TimeState(active: true, selected: false),
      "07:00 PM": TimeState(active: true, selected: false),
      "07:15 PM": TimeState(active: true, selected: false),
      "07:30 PM": TimeState(active: true, selected: false),
      "07:45 PM": TimeState(active: true, selected: false),
      "08:00 PM": TimeState(active: true, selected: false),
      "08:15 PM": TimeState(active: true, selected: false),
      "08:30 PM": TimeState(active: true, selected: false),
      "08:45 PM": TimeState(active: true, selected: false),
      "09:00 PM": TimeState(active: true, selected: false),
      "09:15 PM": TimeState(active: true, selected: false),
      "09:30 PM": TimeState(active: true, selected: false),
      "09:45 PM": TimeState(active: true, selected: false),
      "10:00 PM": TimeState(active: true, selected: false)
    };
    notifyListeners();
  }

void resetMatrixData() {
    for (int i = 0; i < matrixList.length; i++) {
      for (int j = 0; j < matrixList[i].length; j++) {
        for (int k = 0; k < matrixList[i][j].length; k++) {
          matrixList[i][j][k] = "";
        }
      }
    }
    // Notify listeners that the data has changed
    notifyListeners();
  }


  void resetCheckBox(){
    atIsChecked = false;
    ajIsChecked = false;
    ktIsChecked = false;
    lpController.text="";
    notifyListeners();
  }

  void resetControllers(){
    for(int i=0;i<10;++i){
      for(int j=0;j<10;++j){
        controllers[i][j].text = "";
      }
    }
    notifyListeners();
  }

  resetRowColumnsControllers(){
    for(int i=0;i<10;++i){
      rowControllers[i].text = "";
      columnControllers[i].text = "";
    }
  }


}

enum SelectionType { SINGLE, ATOT, ATOJ, KTOT }