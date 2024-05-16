import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:n1gaming/Home/CheckBox.dart';
import 'package:n1gaming/Home/CheckButton.dart';
import 'package:n1gaming/Home/EvenOddCheckBox.dart';
import 'package:n1gaming/Home/InputBox.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';
import 'Button.dart';

class HomeMiddle extends StatefulWidget {
  const HomeMiddle({
    super.key,
    required this.matrixControllers,
    required this.context,
    required this.rowControllers,
    required this.columnControllers,
  });
  final List<List<TextEditingController>> matrixControllers;
  final BuildContext context;
  final List<TextEditingController> rowControllers;
  final List<TextEditingController> columnControllers;

  @override
  RandomNumberGenerator createState() =>
      RandomNumberGenerator(context: context);
}

class RandomNumberGenerator extends State<HomeMiddle> {
  final BuildContext context;

  RandomNumberGenerator({required this.context});

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      widget.rowControllers[i].addListener(() {
        _updateMatrixForRow(i);
      });

      widget.columnControllers[i].addListener(() {
        _updateMatrixForColumn(i);
      });
    }
    _fillDisplayMatrix();
  }

  _fillDisplayMatrix() {
    final matrixList =
        Provider.of<GameSelector>(context, listen: false).matrixList;

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        widget.matrixControllers[i][j].text = matrixList[0][i][j].toString();
      }
    }
  }

  _updateMatrixForRow(int rowIndex) {
  final c = Provider.of<GameSelector>(context, listen: false);
  for (int j = 0; j < 10; j++) {
    if (c.evenIsChecked) {
      if (j % 2 == 0) {
        int sum = (int.tryParse(widget.rowControllers[rowIndex].text) ?? 0) +
            (int.tryParse(widget.columnControllers[j].text) ?? 0);
        widget.matrixControllers[rowIndex][j].text = (sum != 0) ? sum.toString() : "";
      }
    } else if (c.oddIsChecked) {
      if (j % 2 != 0) {
        int sum = (int.tryParse(widget.rowControllers[rowIndex].text) ?? 0) +
            (int.tryParse(widget.columnControllers[j].text) ?? 0);
        widget.matrixControllers[rowIndex][j].text = (sum != 0) ? sum.toString() : "";
      }
    } else {
      int sum = (int.tryParse(widget.rowControllers[rowIndex].text) ?? 0) +
          (int.tryParse(widget.columnControllers[j].text) ?? 0);
      widget.matrixControllers[rowIndex][j].text = (sum != 0) ? sum.toString() : "";
    }
  }
}

_updateMatrixForColumn(int columnIndex) {
  final c = Provider.of<GameSelector>(context, listen: false);
  for (int i = 0; i < 10; i++) {
    if (c.evenIsChecked) {
      if (i % 2 == 0) {
        int sum = (int.tryParse(widget.rowControllers[i].text) ?? 0) +
            (int.tryParse(widget.columnControllers[columnIndex].text) ?? 0);
        widget.matrixControllers[i][columnIndex].text = (sum != 0) ? sum.toString() : "";
      }
    } else if (c.oddIsChecked) {
      if (i % 2 != 0) {
        int sum = (int.tryParse(widget.rowControllers[i].text) ?? 0) +
            (int.tryParse(widget.columnControllers[columnIndex].text) ?? 0);
        widget.matrixControllers[i][columnIndex].text = (sum != 0) ? sum.toString() : "";
      }
    } else {
      int sum = (int.tryParse(widget.rowControllers[i].text) ?? 0) +
          (int.tryParse(widget.columnControllers[columnIndex].text) ?? 0);
      widget.matrixControllers[i][columnIndex].text = (sum != 0) ? sum.toString() : "";
    }
  }
}

bool isChecked = false;
  final TextEditingController controller = TextEditingController();

  void onCheckBoxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false; 
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQuery = MediaQuery.of(context);
    final select = Provider.of<GameSelector>(context, listen: false);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CheckBoxWithContent(content: "A TO J",isChecked: select.ajIsChecked,onChanged: (bool? value) =>
                                  select.toggleAJ(value)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CheckBoxWithContent(content: "K TO T",isChecked: select.ktIsChecked,onChanged: (bool? value) =>
                                  select.toggleKT(value))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EvenOddCheckBox(isCheckedAll: select.allIsChecked,isCheckedEven: select.evenIsChecked,isCheckedOdd: select.oddIsChecked, onChangedAll: (bool? value) =>
                                    select.toggleAll(value),onChangedEven: (bool? value) =>
                                    select.toggleEven(value),
                                    onChangedOdd: (bool? value) =>
                                    select.toggleOdd(value),
                ),
              ],
            ),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.09,
                  height: MediaQuery.of(context).size.height * 0.08,
                  margin: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.yellow, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.035,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: select.lpController,
                          onChanged: (v) {
                            if (v == "") {
                              select.performLP(v);
                              select.setRandomForLP();
                            } else {
                              select.performLP(v);
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly, // Allow only digits
                          ],
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: "SanSerif"),
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                            fillColor: Colors.yellow[600],
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.height * 0.06,
                        alignment: Alignment.center,
                        child: const Text(
                          "LP",
                          style: TextStyle(
                              fontFamily: "SansSerif",
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Check_Button(text: "FP", 
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.height * 0.08, 
                  onChange: (bool? value) =>
                                  select.toggleFP(value), isChecked: select.fpIsChecked)
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
          child: Column(
            children: [
              SizedBox(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(11, (j) {
                  if (j == 0) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.042); 
                  }
                  else if (j<9){
                    return Button(
                        controller: widget.columnControllers[j - 1],
                      );
                  }else{
                    return Container(
                      margin: const EdgeInsets.fromLTRB(8, 1, 5, 1),
                      child: Button(
                        controller: widget.columnControllers[j - 1],
                      ),
                    );
                  }
                  
                }),
              ),
              ),
              for (var i = 0; i < 10; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(11, (j) {
                    if (j == 0) {
                      return Button(
                          controller: widget.rowControllers[i],
                        );
                    } else {
                      return Input_Box(
                          onChange: (v) {
                            if (select.fpIsChecked) {
                              int index1 = i;
                              int index2 = j - 1;
                              int calculatedIndex1 = i + 5;
                              int calculatedIndex2 = j - 1 + 5;
                              // Update the text in multiple controllers
                              select.controllers[index1][index2].text = v;
                              select.controllers[index1][calculatedIndex2]
                                  .text = v;
                              select.controllers[calculatedIndex1][index2]
                                  .text = v;
                              select
                                  .controllers[calculatedIndex1]
                                      [calculatedIndex2]
                                  .text = v;
                              select.controllers[index2][index1].text = v;
                              select.controllers[calculatedIndex2][index1]
                                  .text = v;
                              select.controllers[index2][calculatedIndex1]
                                  .text = v;
                              select
                                  .controllers[calculatedIndex2]
                                      [calculatedIndex1].text = v;
                              

                              select.controllers[index2][index1].text = v;
                              select.controllers[calculatedIndex2][index1]
                                  .text = v;
                              select.controllers[index2][calculatedIndex1]
                                  .text = v;
                              select
                                  .controllers[calculatedIndex2]
                                      [calculatedIndex1]
                                  .text = v;

                              // Set the selection after updating the text
                              select.controllers[index1][index2].selection =
                                  TextSelection.collapsed(offset: v.length);
                            }
                          },
                          text: (i * 10 + (j - 1)).toString().padLeft(2, '0'),
                          color: Colors.white,
                          controller: widget.matrixControllers[i][j - 1],
                        );
                    }
                  }),
                ),
              ],
            ],
          ),
        ),


      ],
    );
  }
}
