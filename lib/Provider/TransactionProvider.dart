// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  Map<String, List<List<String>>> _transactionData = {};
  int _cancelCount = 0;

  Map<String, List<List<String>>> get transactionData => _transactionData;
  int get cancelCount => _cancelCount;

  void updateTransactionData(Map<String, List<List<String>>> newData, int cancelCount) {
    _transactionData = newData;
    _cancelCount = cancelCount;
    notifyListeners(); // Notify listeners to rebuild widgets consuming this provider
  }
}
