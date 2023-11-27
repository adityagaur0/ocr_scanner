import 'package:flutter/material.dart';

class ObjectObjectResultScreen extends StatelessWidget {
  final String text;

  const ObjectObjectResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Text(text),
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
