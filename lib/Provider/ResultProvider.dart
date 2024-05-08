// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class ShowResultProvider extends ChangeNotifier {
  List<dynamic> _data = [];

  List<dynamic> get data => _data;

  void updateResult(List<dynamic> newData) {
    _data = newData;
    notifyListeners();
  }
}