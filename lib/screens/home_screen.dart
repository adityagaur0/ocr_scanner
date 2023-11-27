import 'package:flutter/material.dart';
import 'package:ocr_scanner/recognition/text_recognition.dart';
import 'package:ocr_scanner/results/currency_recognition_result.dart';
import 'package:ocr_scanner/results/read_text_result_screen.dart';
import 'package:ocr_scanner/screens/roughscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // to track weather help overlay has been shown.
  bool helpOverlayShown = false;

  List pages = [
    TextRecognitionScreen(
        resultPageBuilder: (text) => ResultScreen(text: text)),
    TextRecognitionScreen(
        resultPageBuilder: (text) => ResultCurrencyScreen(text: text)),
    const RoughScreen(),
    // const CanvasScreen(),
    // const ProductScannerScreen(),
    // const ObjectRecognitionScreen(),
    // const ScenePage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 56,
        title: const Center(child: Text("ReadText")),
        actions: [
          // IconButton(
          //   onPressed: _openHelpOverlay, //7****
          //   icon: const Icon(Icons.help),
          // ),
        ],
      ),
      drawer: const Drawer(),
      body: pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.text_fields_sharp), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_rupee_rounded), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.data_object), label: ''),
            //          BottomNavigationBarItem(icon: Icon(Icons.draw_outlined), label: ''),
            //        BottomNavigationBarItem(
            //          icon: Icon(Icons.qr_code_scanner), label: ''),
            //    BottomNavigationBarItem(
            //      icon: Icon(Icons.screenshot_monitor), label: ''),
          ],
        ),
      ),
    );
  }
}
