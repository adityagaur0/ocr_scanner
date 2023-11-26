import 'package:flutter/material.dart';

class ResultCurrencyScreen extends StatefulWidget {
  final String text;

  const ResultCurrencyScreen({Key? key, required this.text}) : super(key: key);

  @override
  _ResultCurrencyScreenState createState() => _ResultCurrencyScreenState();
}

class _ResultCurrencyScreenState extends State<ResultCurrencyScreen> {
  late String resultMessage;

  @override
  void initState() {
    super.initState();
    determineResultMessage();
    // speak("${resultMessage}To Repeat this again double tap and to exit this page single tap.");
  }

  void determineResultMessage() {
    if (widget.text.contains("500\n")) {
      resultMessage = "500 Rupees";
    } else if (widget.text.contains("100\n")) {
      resultMessage = "100 Rupees";
    } else if (widget.text.contains("10\n")) {
      resultMessage = "10 Rupees";
    } else if (widget.text.contains("50\n")) {
      resultMessage = "50 Rupees";
    } else if (widget.text.contains("200\n")) {
      resultMessage = "200 Rupees";
    } else {
      resultMessage = "Invalid request.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        onDoubleTap: () {
          //  speak("${resultMessage}To Repeat this again double tap and to exit this page single tap.");
        },
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Center(
                //     child: Lottie.asset('assets/lottie/womenTalk.json',
                //         width: 250)),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    resultMessage,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 13, // Change the font size as needed
                      fontWeight:
                          FontWeight.normal, // Change the font weight as needed
                      color: Colors.black, // Text color
                    ),
                  ),
                ),

                // ElevatedButton(
                //   onPressed: () => speak(widget.textstring),
                //   child: Text("Start Text to Speech"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // flutterTts.stop(); // Stop any ongoing speech
    //flutterTts.shutdown(); // Release FlutterTts resources
    super.dispose();
  }
}
