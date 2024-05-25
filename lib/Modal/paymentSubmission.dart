// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PaymentSubmissionForm extends StatefulWidget {
  const PaymentSubmissionForm({super.key});

  @override
  PaymentSubmissionFormState createState() => PaymentSubmissionFormState();
}

class PaymentSubmissionFormState extends State<PaymentSubmissionForm> {
  final _formKey = GlobalKey<FormState>();
  final _transactionIdController = TextEditingController();
  final _upiIdController = TextEditingController();
  File? _image;

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
    setState(() {
      _image = null;
    });
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
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _transactionIdController,
                    decoration: const InputDecoration(labelText: 'Transaction ID'),
                    validator: _validateTransactionId,
                  ),
                  TextFormField(
                    controller: _upiIdController,
                    decoration: const InputDecoration(labelText: 'UPI ID'),
                    validator: _validateUpiId,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an image')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form submitted')),
                        );
                        _resetForm();
                        Navigator.of(context).pop();
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
                      letterSpacing: 1
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
                      letterSpacing: 1
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
