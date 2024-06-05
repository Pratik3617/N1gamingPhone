// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  Map<String, List<List<String>>> _transactionData = {};

  Map<String, List<List<String>>> get transactionData => _transactionData;

  void updateTransactionData(Map<String, List<List<String>>> newData) {
    _transactionData = newData;
    notifyListeners(); // Notify listeners to rebuild widgets consuming this provider
  }
}
