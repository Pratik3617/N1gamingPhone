import 'package:flutter/material.dart';
import 'package:n1gaming/Modal/paymentSubmission.dart';

void qrDialog(BuildContext context, String imagePath, String upi) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                imagePath,
                width: 180,
                height: 180,
                fit: BoxFit.contain,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.red),
                  );
                },
              ),
              const SizedBox(height: 5),
              Text(
                upi,
                style: const TextStyle(
                  fontFamily: 'SansSerif',
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PaymentSubmissionForm();
                    },
                  );
                },
                child: const Text(
                  'Payment Form',
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
      );
    },
  );
}
