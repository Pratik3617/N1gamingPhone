import 'package:flutter/material.dart';
import 'package:n1gaming/Home/BottomButton.dart';
import 'package:n1gaming/Home/BottomInput.dart';
import 'package:n1gaming/Provider/GameSelector.dart';
import 'package:provider/provider.dart';

class HomeBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final select = Provider.of<GameSelector>(context, listen: false);

    const grandTotal = 0;


    return Container(
      margin: const EdgeInsets.only(top: 3),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          BottomButton(select: select, text: "TODAY",function: select.todayClicked,visible: !(select.selectedToday ?? false),color: Colors.green,textcolor: Colors.black,),
          BottomButton(select: select, text: "NEXT DAY",function: select.nextDayClicked,visible: (select.selectedToday ?? false),color: Colors.green,textcolor: Colors.black,),
          BottomButton(select: select, text: "RESET ALL",function: (){
                      Provider.of<GameSelector>(context, listen: false).resetRowColumnsControllers();
                      Provider.of<GameSelector>(context, listen: false).resetControllers();
                      Provider.of<GameSelector>(context, listen: false).resetTimes();
                      Provider.of<GameSelector>(context, listen: false).resetCheckBox();
                      Provider.of<GameSelector>(context, listen: false).resetMatrixData();
                    
          },visible: true,color: Colors.white,textcolor: Colors.black,),

          BottomButton(select: select, text: "PLAY",function: (){},visible: true,color: Colors.amber,textcolor: Colors.white,),
          const BottomInput(grandTotal: grandTotal, text: "Grand Total"),
          const BottomInput(grandTotal: grandTotal, text: "Net Total"),
        ],
      )
    );
  }
}