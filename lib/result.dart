import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  void showText() {
    if (text.length == 3) {
      print("Currency is: $text");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Call the method to show text based on the condition
    showText();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: text.length == 3
                ? 24.0
                : 16.0, // Adjust font size based on length
          ),
        ),
      ),
    );
  }
}
