import 'package:flutter/material.dart';
import 'package:n1gaming/Home/PointBlock.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';


class HomeRight extends StatefulWidget {
  final List<List<TextEditingController>> controllers;
  final BuildContext context;
  final ValueChanged<int> onGrandTotalChange;

  const HomeRight({
    super.key,
    required this.controllers,
    required this.context,
    required this.onGrandTotalChange,
  });

  @override
  _updatePoints createState() => _updatePoints(context: context);
}

class _updatePoints extends State<HomeRight> {
  final BuildContext context;
  List<int> sumList = List<int>.filled(20, 0);

  _updatePoints({required this.context});

  ValueNotifier<int> currentValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    for (var row in widget.controllers) {
      for (var controller in row) {
        controller.addListener(_updateSum);
      }
    }
    // _updateSum();
  }

  _updateSum() {
    List<int> newSum = List<int>.filled(20, 0);
    final matrixList =
        Provider.of<GameSelector>(context, listen: false).matrixList;
    final checkBoxValues =
        Provider.of<GameSelector>(context, listen: false).checkBoxValues;
    final checkbox = Provider.of<GameSelector>(context, listen: false).checkbox;
    // final selectedAlphabet =
        // Provider.of<GameSelector>(context, listen: false).selectedAlphabet;

    for (int i = 0; i < 20; i++) {
      if (checkBoxValues[checkbox[i]] == true) {
        newSum[i] = 0;
        for (int j = 0; j < 10; j++) {
          for (int k = 0; k < 10; k++) {
            newSum[i] += int.tryParse(widget.controllers[j][k].text) ?? 0;
          }
        }
      } else {
        for (int j = 0; j < 10; j++) {
          for (int k = 0; k < 10; k++) {
            newSum[i] += int.tryParse(matrixList[i][j][k] ?? "0") ?? 0;
          }
        }
      }
    }

    setState(() {
      for (int i = 0; i < 20; i++) {
        sumList[i] = newSum[i] * 2;
      }
    });

    // Calculate the grand total and update the notifier
    int grandTotal = sumList.reduce((value, element) => value + element);
    currentValueNotifier.value = grandTotal;
  }

  @override
  void dispose() {
    for (var row in widget.controllers) {
      for (var controller in row) {
        controller.removeListener(_updateSum);
      }
    }
    currentValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start, 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.11,
        height: MediaQuery.of(context).size.height * 0.08,
        margin: const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Points",
                style: TextStyle(
                  fontFamily: "SansSerif",
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      const PointsBlock(
        text1: " A TO J",
        text2: " K TO T",
        color: Colors.white,
        textColor: Colors.black,
      ),
      for (int i = 0; i < 10; i++)
        PointsBlock(
          text1: "${sumList[i]}",
          text2: "${sumList[i + 10]}",
          textColor: Colors.black,
          color: Colors.amber,
        ),
    ]);
  }

  @override
  void didUpdateWidget(covariant HomeRight oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.onGrandTotalChange(currentValueNotifier.value);
  }
}
