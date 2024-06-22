// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:n1gaming/API/Home/PaymentApi.dart';
import 'package:n1gaming/Modal/ErrorModal.dart';
import 'package:n1gaming/Modal/loadingModal.dart';
import 'package:n1gaming/Modal/successModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentSubmissionForm extends StatefulWidget {
  const PaymentSubmissionForm({super.key});

  @override
  PaymentSubmissionFormState createState() => PaymentSubmissionFormState();
}

class PaymentSubmissionFormState extends State<PaymentSubmissionForm> {
  final _formKey = GlobalKey<FormState>();
  final _transactionIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _upiIdController = TextEditingController();
  File? _image;
  String? _selectedPaymentMethod;

  List<String> paymentMethods = ['PhonePe_UPI','Paytm_UPI','GPay_UPI', 'other'];

  String? _validateTransactionId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Transaction ID is required';
    }
    return null;
  }

  String? _validateUpiId(String? value) {
    if (value == null || value.isEmpty) {
      return 'UPI ID is required';
    }
    if (!value.contains('@')) {
      return 'Invalid UPI ID format';
    }
    return null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _resetForm() {
    _transactionIdController.clear();
    _upiIdController.clear();
    _amountController.clear();
    setState(() {
      _image = null;
      _selectedPaymentMethod = null;
    });
  }

  Future<int> submitPayment() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token == null) {
      return 401; // Unauthorized
    }

    final response = await paymentAPI(
      _amountController.text,
      _transactionIdController.text,
      _image!,
      _selectedPaymentMethod!,
      _upiIdController.text,
      token,
    );

    // var responseBody = json.decode(response.body);
    return response.statusCode;
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero, // Remove padding around the dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.98,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "PAYMENT",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 30, 58, 58),
                  letterSpacing: 1,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Payment Method',
                        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        isDense: true,
                      ),
                      value: _selectedPaymentMethod,
                      items: paymentMethods.map((String method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPaymentMethod = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a payment method';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      controller: _transactionIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Transaction ID',
                        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        isDense: true,
                        suffixIcon: Icon(Icons.perm_identity)
                      ),
                      validator: _validateTransactionId,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        isDense: true,
                        suffixIcon: Icon(Icons.currency_rupee)
                      ),
                      validator: _validateTransactionId,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (_selectedPaymentMethod == 'PhonePe_UPI' || _selectedPaymentMethod == 'Paytm_UPI' || _selectedPaymentMethod == 'GPay_UPI')
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                      controller: _upiIdController,
                      decoration: const InputDecoration(
                        labelText: 'UPI ID',
                        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                        isDense: true,
                      ),
                      validator: _validateUpiId,
                    ),
                    ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text(
                          'Pick Image',
                          style: TextStyle(
                            color: Color.fromARGB(255, 30, 58, 58),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _image == null
                          ? const Text('No image selected.')
                          : Image.file(_image!, height: 50, width: 50), // Small thumbnail of the image
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an image')),
                        );
                      } else {
                        showLoadingDialog(context);
                        int statusCode = await submitPayment();
                        
                        hideLoadingDialog(context);
                        if (statusCode == 201) {
                          showSuccessDialog(context, "Payment form submitted successfully!!!");
                        } else {
                          showErrorDialog(context, "Payment form submission failed!!!");
                        }
                        _resetForm();
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 30, 58, 58)),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: "YoungSerif",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _resetForm();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 30, 58, 58)),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: "YoungSerif",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}
