import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> resultMessages = [];

    if (text.contains("500\n")) {
      resultMessages.add("Yes for 500");
    }

    if (text.contains("100\n")) {
      resultMessages.add("Yes for 100");
    }

    if (text.contains("10\n")) {
      resultMessages.add("Yes for 10");
    }

    if (text.contains("50\n")) {
      resultMessages.add("Yes for 50");
    }

    if (text.contains("200\n")) {
      resultMessages.add("Yes for 200");
    }

    String resultMessage = resultMessages.isNotEmpty
        ? resultMessages.join(", ") // Join messages if there are any
        : "Condition not met";

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
            Text(text),
          ],
        ),
      ),
    );
  }
}
