import 'package:flutter/material.dart';
import 'package:n1gaming/Modal/paymentSubmission.dart';

void qrDialog(BuildContext context, String imagePath, String upi) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Use the QR or UPI for payment, then submit the form given below!",
                  style: TextStyle(
                    fontFamily: 'YoungSerif',
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  child: Image.network(
                    imagePath,
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                ),
                Text(
                  upi,
                  style: const TextStyle(
                    fontFamily: 'SansSerif',
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const PaymentSubmissionForm();
                      },
                    );
                  },
                  child: const Text(
                    'Payment Submission Form',
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 30, 58, 58),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
