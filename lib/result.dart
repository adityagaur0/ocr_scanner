import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Call the method to show text based on the condition
    bool _isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              child: _isNumeric(text) && int.parse(text) <= 100
                  ? Text("yes")
                  : Text("No"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
