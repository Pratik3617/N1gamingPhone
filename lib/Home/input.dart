import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LPinput extends StatelessWidget {
  final TextEditingController controller;

  LPinput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width * 0.09,
                  height: MediaQuery.of(context).size.height * 0.08,
                  margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          // controller: select.lpController,
                          // onChanged: (v) {
                          //   if (v == "") {
                          //     select.performLP(v);
                          //     select.setRandomForLP();
                          //   } else {
                          //     select.performLP(v);
                          //   }
                          // },
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
                            fillColor: Colors.amber,
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
                        width: MediaQuery.of(context).size.width * 0.03,
                        height: MediaQuery.of(context).size.height * 0.05,
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
                );
  }
}
