import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});
  @override
  void initState() {
    // super.initState();
    show(text);
  }

  show(text) {
    if (text.length() == 3) {
      print(text);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Text(text),
        ),
      );
}
