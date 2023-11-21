// import 'package:flutter/material.dart';
// import 'package:ocr_scanner/homescreen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: HomeScreen());
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:ocr_scanner/image_processing.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:torch_compat/torch_compat.dart';
// // import 'package:flutter_tts/flutterTts.dart';

// // Your existing code for the main file

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       debugShowCheckedModeBanner: false,
//       home: MainScreen(camera: firstCamera),
//     ),
//   );
// }

// class MainScreen extends StatefulWidget {
//   final CameraDescription camera;
//   const MainScreen({
//     super.key,
//     required this.camera,
//   });

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.high,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     // TorchCompat.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text('Noteify'))),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Center(
//             child: Container(
//               height: 180.0,
//               width: 180.0,
//               child: FittedBox(
//                 child: FloatingActionButton(
//                   child: Icon(Icons.camera_alt),
//                   onPressed: () async {
//                     try {
//                       // TorchCompat.turnOn();
//                       await _initializeControllerFuture;
//                       final path = join(
//                         (await getTemporaryDirectory()).path,
//                         '${DateTime.now()}.png',
//                       );
//                       await _controller.takePicture(path);
//                       // TorchCompat.turnOff();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DisplayPictureScreen(path),
//                         ),
//                       );
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CameraDescription> cameras = [];
  bool isWorking = false;
  String result = "";
  CameraController? cameraController;
  CameraImage? imgCamera;

  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController!.startImageStream((imageFromStream) {
          if (!isWorking) {
            setState(() {
              isWorking = true;
              imgCamera = imageFromStream;
              runModelonStreamFrames();
            });
          }
        });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  runModelonStreamFrames() async {
    if (imgCamera != null) {
      try {
        var recognitions = await Tflite.runModelOnFrame(
          bytesList: imgCamera!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: imgCamera!.height,
          imageWidth: imgCamera!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
        );
        result = '';

        recognitions!.forEach((response) {
          result += response["label"] +
              (response["confidence"] as double).toStringAsFixed(2);
        });

        setState(() {
          result;
        });

        print(result);

        isWorking = false;
      } catch (e) {
        print('Error running model: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 60, 15, 5),
              child: Text(
                "Dogs Breed Recognizer",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              initCamera();
                            },
                            child: Container(
                              height: 720.0,
                              width: 720.0,
                              child: imgCamera == null
                                  ? Container(
                                      height: 270.0,
                                      width: 360.0,
                                      child: Icon(
                                        Icons.photo_camera_front_rounded,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    )
                                  : AspectRatio(
                                      aspectRatio:
                                          cameraController!.value.aspectRatio,
                                      child: CameraPreview(cameraController!),
                                    ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 55.0),
                            child: SingleChildScrollView(
                              child: Text(
                                result,
                                style: const TextStyle(
                                  backgroundColor: Colors.white54,
                                  fontSize: 25.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
