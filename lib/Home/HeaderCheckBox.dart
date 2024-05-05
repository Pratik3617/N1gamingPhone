import 'package:flutter/material.dart';
import 'package:n1gaming/Home/CheckBox.dart';
import 'package:n1gaming/Home/EvenOddCheckBox.dart';
import 'package:n1gaming/Home/FPCheckBox.dart';
import 'package:n1gaming/Home/input.dart';

class HeaderCheckBox extends StatefulWidget {
  @override
  HeaderCheckBoxWidget createState() => HeaderCheckBoxWidget();
}

class HeaderCheckBoxWidget extends State<HeaderCheckBox> {
  bool isChecked = false;
  final TextEditingController controller = TextEditingController();

  void onCheckBoxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.99,
      height: MediaQuery.of(context).size.height*0.1,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckBoxWithContent(isChecked: isChecked,content: "A To T",onChanged: onCheckBoxChanged),
              CheckBoxWithContent(isChecked: isChecked,content: "A To J",onChanged: onCheckBoxChanged),
              CheckBoxWithContent(isChecked: isChecked,content: "K To T",onChanged: onCheckBoxChanged),
              EvenOddCheckBox(isChecked: isChecked, onChanged: onCheckBoxChanged),
              LPinput(controller: controller),
              FPCheckBox(isChecked: isChecked,content: "FP",onChanged: onCheckBoxChanged),
              
              
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.08,
                padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text("Points",
                        style: TextStyle(
                              fontFamily: 'SansSerif',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Color.fromARGB(255, 30, 58, 58),
                            ),
                ),
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}
