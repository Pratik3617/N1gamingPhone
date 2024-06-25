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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(Icons.wifi_off, size: 120, color: Colors.white),
                ),
                Text(
                  "No internet connection",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        messageText: Center(
          child: Text(
            "Connect to internet to proceed!!!",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white),
          ),
        ),
        duration: Duration(days: 1),
        isDismissible: false,
        shouldIconPulse: true,
      );
    } else {
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}
