import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomInput extends StatefulWidget {

  final int grandTotal;
  final String text;
  const BottomInput(
      {super.key,
      required this.grandTotal,
      required this.text,
      });

  @override
  BottomInputWidget createState() => BottomInputWidget();
  
}

class BottomInputWidget extends State<BottomInput>{
  @override
  Widget build(BuildContext context){
    return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("${widget.text} : ",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SansSerif",
                          fontSize: MediaQuery.of(context).size.width * 0.02)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextField(
                      controller: TextEditingController(text: "${widget.grandTotal}"),
                      keyboardType:
                          TextInputType.number, // Set keyboard type to numeric
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        // Allow only digits
                      ],
                      style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "SanSerif"),
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: TextField(
                        controller: TextEditingController(text: "${widget.grandTotal}"),
                        keyboardType: TextInputType
                            .number, // Set keyboard type to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                        ],
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "SanSerif"),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ),
          );
  }
}
