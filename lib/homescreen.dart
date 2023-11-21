import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ocr_scanner/main.dart';

// import 'package:get/get.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelonStreamFrames(),
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
    // TODO: implement dispose
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
        // print(response);
        result += response["label"] +
            (response["confidence"] as double).toStringAsFixed(2);
      });

      // showModalBottomSheet(
      //     context: context,
      //     builder: (ctx) => Result(result: result),
      //     isScrollControlled: true);
      setState(() {
        result;
      });

      print(result);

      isWorking = false;
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
                  // image: DecorationImage(
                  //     image: AssetImage("assets/back.jpg"), fit: BoxFit.fill),
                  color: Colors.black),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // Center(
                        //   child: Container(
                        //     height: 320,
                        //     width: 360,
                        //     child: Image.asset("assets/frame.jpg"),
                        //   ),
                        // ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              initCamera();
                            },
                            child: Container(
                              // margin: EdgeInsets.only(top: 35.0),
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
                    // Center(
                    //   child: Container(
                    //     margin: const EdgeInsets.only(top: 55.0),
                    //     child: SingleChildScrollView(
                    //       child: Text(
                    //         result,
                    //         style: const TextStyle(
                    //           backgroundColor: Colors.white54,
                    //           fontSize: 25.0,
                    //           color: Colors.black,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ),
                    // )
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
