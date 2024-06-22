import 'package:flutter/material.dart';

class AccountDetails {
  final String id;
  final String type;
  final double amount;
  final String status;
  final String date;

  AccountDetails({
    required this.id,
    required this.type,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    return AccountDetails(
      id: json['withdrawal_id'] ?? json['txn_id'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      date: json['created_at'],
      type: json['type'],
    );
  }
}

class AccountBox extends StatelessWidget {
  final AccountDetails accountDetails;

  const AccountBox({super.key,required this.accountDetails});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.23, // Reduced height
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.0), // Add border
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                accountDetails.id,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansSerif',
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                accountDetails.date,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansSerif',
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${accountDetails.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansSerif',
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                accountDetails.type,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansSerif',
                  color: accountDetails.type == 'withdrawal' ? Colors.green : Colors.red,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                accountDetails.status,
                style: TextStyle(
                  fontSize: 14.0,
                  color: accountDetails.status == 'approve' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SansSerif',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
