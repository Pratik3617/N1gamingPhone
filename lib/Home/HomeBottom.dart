import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n1gaming/Home/BottomButton.dart';
import 'package:n1gaming/Home/BottomInput.dart';
import 'package:n1gaming/Home/CheckBox.dart';
import 'package:n1gaming/Home/CheckButton.dart';
import 'package:n1gaming/Home/CustomButton.dart';
import 'package:n1gaming/Home/printDialog.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBottom extends StatefulWidget {
  String nextGame;
  HomeBottom({Key? key,required this.nextGame}) : super(key: key);

  @override
  _HomeBottomState createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {
  String? username;
  int countTimeSlots = 0;

  void getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero, // Remove padding around the dialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SingleChildScrollView(
            child: Consumer<GameSelector>(
              builder: (context, value, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InputField(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.08,
                            fontSize: 16,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade300,
                            ),
                            text: "(Enter number of games to select)",
                            onChange: (v) {
                              try {
                                // Your logic for handling input field change
                              } catch (e) {
                                print("Enter a number only");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Check_Button(
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: MediaQuery.of(context).size.height * 0.08,
                          isChecked: value.allTimesSelected,
                          fontSize: 16,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                          ),
                          text: "Check to select all games",
                          onChange: (bool? v) {
                            DateTime now = DateTime.now();
                            DateTime tomorrow = DateTime(
                              now.year,
                              now.month,
                              now.day + 1,
                            );
                            DateTime tomorrowTime = DateTime(
                              tomorrow.year,
                              tomorrow.month,
                              tomorrow.day,
                              0,
                              0,
                              0,
                            );
                            value.allTimesSelected = v!;
                            if (v == true) {
                              for (var element in value.times) {
                                if (!value.isTimePassed(
                                    element,
                                    value.showNextDayTimes ? tomorrowTime : now)) {
                                  value.timesValues[element]!.selected = v;
                                }
                              }
                            } else {
                              for (var element in value.times) {
                                value.timesValues[element]!.selected = v;
                              }
                            }
                            setState(() {
                              countTimeSlots = _calculateTimeSlots(value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomButton(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.08,
                          text: "Click here to clear all selection",
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                          ),
                          onClick: () {
                            value.allTimesSelected = false;
                            for (var element in value.times) {
                              value.timesValues[element]!.selected = false;
                            }
                            value.notifyListeners();
                            setState(() {
                              countTimeSlots = 0;
                            });
                          },
                        ),
                        CustomButton(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          text: "Close",
                          onClick: () {
                            value.showTimes = false;
                            value.notifyListeners();
                            Navigator.of(context).pop();
                          },
                        ),
                        CustomButton(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          ),
                          text: "Ok",
                          onClick: () {
                            value.showTimes = false;
                            value.notifyListeners();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    SingleChildScrollView(
                      child: Wrap(
                        children: [
                          for (var i = 0; i < value.times.length; i++) ...[
                            Check_Button(
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: MediaQuery.of(context).size.height * 0.08,
                              fontSize: 10,
                              isChecked: value.timesValues[value.times[i]]?.active ==
                                      false
                                  ? false
                                  : (value.timesValues[value.times[i]]?.selected ??
                                      false),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                              ),
                              text: value.times[i],
                              onChange: (bool? v) {
                                DateTime now = DateTime.now();
                                DateTime tomorrow = DateTime(
                                  now.year,
                                  now.month,
                                  now.day + 1,
                                );
                                DateTime tomorrowTime = DateTime(
                                  tomorrow.year,
                                  tomorrow.month,
                                  tomorrow.day,
                                  0,
                                  0,
                                  0,
                                );
                                if (!value.isTimePassed(
                                    value.times[i],
                                    value.showNextDayTimes ? tomorrowTime : now)) {
                                  value.timesValues[value.times[i]]!.selected = v!;
                                  value.notifyListeners();
                                  setState(() {
                                    countTimeSlots = _calculateTimeSlots(value);
                                  });
                                }
                              },
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}


  int _calculateTimeSlots(GameSelector value) {
    int count = 0;
    value.timesValues.forEach((key, value) {
      if (value.selected == true) {
        count++;
      }
    });
    return count;
  }

  void _showTimeSlotModal(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String txnId = "TXN${DateTime.now().millisecondsSinceEpoch}";
    List<String> selectedCharacters = [];
    String selectedTimes = "";
    int totalPoints = 0;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String nextDayDate =
        DateFormat('dd/MM/yyyy').format(now.add(const Duration(days: 1)));

    return Consumer<GameSelector>(
      builder: (context, select, _) {
        return Container(
          margin: const EdgeInsets.only(top: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomButton(
                select: select,
                text: "TODAY",
                function: () {
                  select.todayClicked();
                  _showModal(context);
                },
                visible: !(select.selectedToday ?? false),
                color: Colors.green,
                textcolor: Colors.black,
              ),
              BottomButton(
                select: select,
                text: "NEXT DAY",
                function: () {
                  select.nextDayClicked();
                  _showModal(context);
                },
                visible: (select.selectedToday ?? false),
                color: Colors.green,
                textcolor: Colors.black,
              ),
              BottomButton(
                select: select,
                text: "RESET ALL",
                function: () {
                  select.resetMatrixData();
                  select.resetRowColumnsControllers();
                  select.resetControllers();
                  select.resetTimes();
                  select.resetCheckBox();
                  setState(() {
                    countTimeSlots = 0; // Reset countTimeSlots as well
                  });
                },
                visible: true,
                color: Colors.white,
                textcolor: Colors.black,
              ),
              BottomButton(
                select: select,
                text: "PLAY",
                function: () {
                  setState(() {
                    countTimeSlots = 0;
                    selectedTimes = "";
                  });

                  select.timesValues.forEach((key, value) {
                    if (value.selected == true) {
                      countTimeSlots += 1;
                      selectedTimes +=
                          "${select.showNextDayTimes ? nextDayDate : formattedDate} $key,";
                    }
                  });

                  if(select.grandTotal == 0){
                    _showTimeSlotModal(context, "Please add tickets!!!");
                  }else{
                    selectedCharacters.clear();
                    final select3 =
                        Provider.of<GameSelector>(context, listen: false);
                    for (int i = 0; i < 10; i++) {
                      for (int j = 0; j < 10; j++) {
                        String? textValue = select3.controllers[i][j].text;
                        if (select3.activeMatrix.length == 1) {
                          select3.matrixList[select3.checkbox
                                  .indexOf(select3.activeMatrix)][i][j] =
                              textValue != "" ? textValue : "";
                        } else if (select3.activeMatrix == "AT") {
                          for (int k = 0; k < 20; k++) {
                            select3.matrixList[k][i][j] =
                                textValue != "" ? textValue : "";
                          }
                        } else if (select3.activeMatrix == "AJ") {
                          for (int k = 0; k < 10; k++) {
                            select3.matrixList[k][i][j] =
                                textValue != "" ? textValue : "";
                          }
                        } else if (select3.activeMatrix == "KT") {
                          for (int k = 10; k < 20; k++) {
                            select3.matrixList[k][i][j] =
                                textValue != "" ? textValue : "";
                          }
                        }
                      }
                    }

                    for (int i = 0; i < 20; i++) {
                      for (int j = 0; j < 10; j++) {
                        for (int k = 0; k < 10; k++) {
                          if (select3.matrixList[i][j][k] != "" &&
                              select3.matrixList[i][j][k] != "0") {
                            selectedCharacters.add(
                                "${select3.checkbox[i]}-$j$k - ${int.parse(select3.matrixList[i][j][k] ?? "0") * 2}");
                            totalPoints += (int.parse(
                                    select3.matrixList[i][j][k] ?? "0") *
                                2);
                          }
                        }
                      }
                    }

                    String slipDate = DateFormat('dd/MM/yyyy HH:mm:ss')
                        .format(DateTime.now());

                     DateTime now = DateTime.now();
                    DateTime thresholdTime = DateTime(now.year, now.month, now.day, 23, 0, 0);

                    if (countTimeSlots == 0) {
                      DateTime selectedDate = now.isBefore(thresholdTime) ? now : now.add(Duration(days: 1));
                      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                      String formattedTime = widget.nextGame.substring(0, 5); 
                      String period = widget.nextGame.substring(8); 

                      selectedTimes = "$formattedDate $formattedTime$period";
                      print(selectedTimes);
                      countTimeSlots += 1;
                    }
                    final body = {
                      "transaction_id": txnId,
                      "gamedate_times": selectedTimes
                          .split(",")
                          .map((time) => time.trim())
                          .where((time) => time.isNotEmpty)
                          .toList(),
                      "slipdate_time": slipDate,
                      "points": (totalPoints).toString(),
                      "GamePlay": selectedCharacters,
                      "total_amount": totalPoints * countTimeSlots
                    };

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildPrintDialog(
                          context: context,
                          userName: username!,
                          txnId: txnId,
                          slipDate: slipDate,
                          selectedTimes: selectedTimes,
                          selectedCharacters: selectedCharacters,
                          totalPoints: totalPoints,
                          countTimeSlots: countTimeSlots,
                          body: body,
                        );
                      },
                    );
                  }
                },
                visible: true,
                color: Colors.amber,
                textcolor: Colors.white,
              ),
              BottomInput(grandTotal: select.grandTotal, text: "Grand Total"),
              BottomInput(
                  grandTotal: select.grandTotal * countTimeSlots,
                  text: "Net Total"),
            ],
          ),
        );
      },
    );
  }
}
