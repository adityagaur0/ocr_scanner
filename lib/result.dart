import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String resultMessage = '';

    if (text.contains("500\n")) {
      resultMessage = "Yes for 500";
    } else if (text.contains("100\n")) {
      resultMessage = "Yes for 100";
    } else if (text.contains("10\n")) {
      resultMessage = "Yes for 10";
    } else if (text.contains("50\n")) {
      resultMessage = "Yes for 50";
    } else if (text.contains("200\n")) {
      resultMessage = "Yes for 200";
    } else {
      resultMessage = "Condition not met";
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
              child: Text(resultMessage),
            ),
            SizedBox(
              height: 20,
            ),
            // Text(text),
          ],
        ),
      ),
    );
  }
}
