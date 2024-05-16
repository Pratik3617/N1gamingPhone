import 'package:flutter/material.dart';
import 'package:n1gaming/Provider/GameSelector.dart';

class BottomButton extends StatelessWidget {

  final GameSelector select;
  final String text;
  final Function function;
  final bool visible;
  final Color color;
  final Color textcolor;

  // Constructor
  BottomButton({
    required this.select,
    required this.text,
    required this.function,
    required this.visible,
    required this.color,
    required this.textcolor,
  });

  

  @override
  Widget build(BuildContext context){
    
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: visible,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  child: ElevatedButton(
                    onPressed: () {
                      function();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(color),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.yellow, width: 1.0),
                      ),
                      
                    ),
                    child: Text(text,
                        style: TextStyle(
                            fontFamily: "SansSerif",
                            letterSpacing: 1.0,
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            color: textcolor,
                            fontWeight: FontWeight.bold
                        )),
                            
                  ),
                ),
              ),
            ],
          );
  }
}