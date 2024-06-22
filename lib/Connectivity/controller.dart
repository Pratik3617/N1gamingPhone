import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetController extends GetxController{
  Connectivity _connectivity = Connectivity();

  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(NetStatus);
  }

  NetStatus(ConnectivityResult result){
    if(result == ConnectivityResult.none){
      Get.rawSnackbar(
        titleText: Container(
          width: double.infinity,
          height: Get.size.height*0.835,
          child: Column(children: [
            Center(
              child: Icon(Icons.wifi_off,size: 120,color: Colors.white,),
            ),
            Text("No internet connection",style: TextStyle(
              fontSize: 25,
              fontWeight:FontWeight.bold,
              color: Colors.white
            ),)
          ],),
        ),
        message: "Connect to internet to proceed!!!",
        duration: Duration(days: 1),
        isDismissible: false,
        shouldIconPulse: true
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}