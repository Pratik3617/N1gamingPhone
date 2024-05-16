import 'package:flutter/material.dart';
import 'package:n1gaming/Home/CheckBox.dart';
import 'package:n1gaming/Home/CheckButton.dart';
import 'package:n1gaming/Home/Page.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';

class HomeLeft extends StatefulWidget {
  @override
  HomeLeftWidget createState() => HomeLeftWidget();
}


class HomeLeftWidget extends State<HomeLeft>{
  bool isChecked = false;
  final TextEditingController controller = TextEditingController();

  void onCheckBoxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<GameSelector>(
              builder: (context, select, child) {
                  return CheckBoxWithContent(isChecked: select.atIsChecked,content: "A To T",onChanged: (bool? value) {
                            select.toggleAT(value);
                          },);
              }
        ),
        
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.06,
          margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageWidget(content: "Pg. up"),
              PageWidget(content: "Pg. dn"),
            ],
          ),
        ),

        for (int i = 0; i < 10; ++i) ...[
          Consumer<GameSelector>(
            builder: (context, select, child) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height:  MediaQuery.of(context).size.height * 0.06,
                margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Check_Button(
                        width: MediaQuery.of(context).size.width * 0.072,
                        height: MediaQuery.of(context).size.height * 0.06,
                        isChecked: select.atIsChecked || select.ajIsChecked
                            ? true
                            : select.activeMatrix == select.checkbox[i],
                        text: select.checkbox[i],
                        onChange: (bool? value) {
                          // activeMatrix.clear();
                          if (select.atIsChecked ||
                              select.ajIsChecked ||
                              select.ktIsChecked) {
                            return;
                          }
                          select.prevActiveMatrix = select.activeMatrix;
                          select.activeMatrix = select.checkbox[i];
                          select.handleCheckboxChange(
                              select.checkbox[i], value);
                        }),
                    Check_Button(
                        width: MediaQuery.of(context).size.width * 0.072,
                        height: MediaQuery.of(context).size.height * 0.06,
                        isChecked: select.atIsChecked || select.ktIsChecked
                            ? true
                            : select.activeMatrix == select.checkbox[i + 10],
                        text: select.checkbox[i + 10],
                        onChange: (bool? value) {
                          if (select.atIsChecked ||
                              select.ajIsChecked ||
                              select.ktIsChecked) {
                            return;
                          }
                          // activeMatrix.clear();
                          select.prevActiveMatrix = select.activeMatrix;
                          select.activeMatrix = select.checkbox[i + 10];
                          select.handleCheckboxChange(
                              select.checkbox[i + 10], value);
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );

  }
}