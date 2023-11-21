// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_tts/flutter_tts.dart';

// // // class ResultScreen extends StatelessWidget {
// // //   final String textstring;
// // //   final FlutterTts flutterTts = FlutterTts();

// // //   ResultScreen({super.key, required this.textstring});

// // //   speak(String text) async {
// // //     await flutterTts.setLanguage("en-US");
// // //     await flutterTts.setPitch(1); // 0.5 to 1.5
// // //     await flutterTts.speak(text);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) => Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Result'),
// // //         ),
// // //         body: SingleChildScrollView(
// // //           child: Container(
// // //             padding: const EdgeInsets.all(30.0),
// // //             child: Column(
// // //               children: [
// // //                 Text(textstring),
// // //                 ElevatedButton(
// // //                   onPressed: () => speak(textstring),
// // //                   child: Text("Start Text to Speech"),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       );
// // //   @override
// // //   void dispose() {
// // //     flutterTts.stop(); // Stop any ongoing speech
// // //     flutterTts.shutdown(); // Release FlutterTts resources
// // //     super.dispose();
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_tts/flutter_tts.dart';

// // class ResultScreen extends StatefulWidget {
// //   final String textstring;

// //   ResultScreen({Key? key, required this.textstring}) : super(key: key);

// //   @override
// //   _ResultScreenState createState() => _ResultScreenState();
// // }

// // class _ResultScreenState extends State<ResultScreen> {
// //   final FlutterTts flutterTts = FlutterTts();

// //   speak(String text) async {
// //     await flutterTts.setLanguage("en-US");
// //     await flutterTts.setPitch(1); // 0.5 to 1.5
// //     await flutterTts.speak(text);
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     speak(widget
// //         .textstring); // Automatically start speaking when the screen is initialized
// //   }

// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Result'),
// //         ),
// //         body: SingleChildScrollView(
// //           child: Container(
// //             padding: const EdgeInsets.all(30.0),
// //             child: Column(
// //               children: [
// //                 Text(widget.textstring),
// //                 // ElevatedButton(
// //                 //   onPressed: () => speak(widget.textstring),
// //                 //   child: Text("Start Text to Speech"),
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       );

// //   @override
// //   void dispose() {
// //     flutterTts.stop(); // Stop any ongoing speech
// //     //flutterTts.shutdown(); // Release FlutterTts resources
// //     super.dispose();
// //   }
// // }

// // // class ResultScreen extends StatefulWidget {
// // //   final String textstring;

// // //   ResultScreen({Key? key, required this.textstring, required this._scanImage})
// // //       : super(key: key);
// // //   Future<void> _scanImage;
// // //   @override
// // //   State<ResultScreen> createState() => _ResultScreenState();
// // // }

// // // class _ResultScreenState extends State<ResultScreen> {
// // //   final FlutterTts flutterTts = FlutterTts();
// // //   speak(String text) async {
// // //     await flutterTts.setLanguage("en-US");
// // //     await flutterTts.setPitch(1); // 0.5 to 1.5
// // //     await flutterTts.speak(text);
// // //   }

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     speak(widget
// // //         .textstring); // Automatically start speaking when the screen is initialized
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       padding: const EdgeInsets.only(bottom: 30.0),
// // //       child: Center(
// // //         child: ElevatedButton(
// // //           onPressed: Widget,
// // //           child: const Text('Scan text'),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     flutterTts.stop(); // Stop any ongoing speech
// // //     //flutterTts.shutdown(); // Release FlutterTts resources
// // //     super.dispose();
// // //   }
// // // }


// // Construct the path where the image should be saved using the
//                       // pattern package.
//                       final path = join(
//                         // Store the picture in the temp directory.
//                         // Find the temp directory using the `path_provider` plugin.
//                         (await getTemporaryDirectory()).path,
//                         '${DateTime.now()}.png',
//                       );

//                       // Attempt to take a picture and log where it's been saved.
//                       await _controller.takePicture(path);

//                       // If the picture was taken, display it on a new screen.
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DisplayPictureScreen(path),
//                         ),
//                       );
//                     } catch (e) {
//                       // If an error occurs, log the error to the console.
//                       print(e);
//                     }


            