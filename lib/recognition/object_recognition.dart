import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr_scanner/camera/camera_helper.dart';
import 'package:ocr_scanner/recognition/utils.dart';
import 'package:ocr_scanner/results/object_recognition_result.dart';
import 'package:ocr_scanner/results/read_text_result_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class ObjectRecognitionScreen extends StatefulWidget {
  const ObjectRecognitionScreen({super.key});
  // final Widget Function(String text) resultPageBuilder;

  @override
  State<ObjectRecognitionScreen> createState() =>
      _ObjectRecognitionScreenState();
}

class _ObjectRecognitionScreenState extends State<ObjectRecognitionScreen> {
  final textRecognizer = TextRecognizer();
  late final CameraManager _cameraManager;
  bool _isCameraInitializing = false;
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;

  @override
  void initState() {
    super.initState();
    _cameraManager = CameraManager(() {
      setState(() {}); // Trigger the state update in ObjectRecognitionScreen
    });
    _initializeLabeler();
  }

  @override
  void dispose() {
    _cameraManager.dispose();
    _canProcess = false;
    _imageLabeler.close();
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cameraManager.future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_cameraManager.isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (!_isCameraInitializing) {
                      _isCameraInitializing = true;
                      _cameraManager.initCameraController(snapshot.data!);
                    }

                    return Center(
                      child: CameraPreview(_cameraManager.cameraController!),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              backgroundColor: _cameraManager.isPermissionGranted
                  ? Colors.transparent
                  : null,
              body: _cameraManager.isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: _detectObject,
                              child: const Text('Scan text'),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          'Camera permission denied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  void _initializeLabeler() async {
    // uncomment next line if you want to use the default model
    // _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

    // uncomment next lines if you want to use a local model
    // make sure to add tflite model to assets/ml
    // final path = 'assets/ml/lite-model_aiy_vision_classifier_birds_V1_3.tflite';
    // final path = 'assets/ml/object_labeler_flowers.tflite';
    final path = 'assets/object_labeler.tflite';
    final modelPath = await getAssetPath(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    _imageLabeler = ImageLabeler(options: options);

    // uncomment next lines if you want to use a remote model
    // make sure to add model to firebase
    // final modelName = 'bird-classifier';
    // final response =
    //     await FirebaseImageLabelerModelManager().downloadModel(modelName);
    // print('Downloaded: $response');
    // final options =
    //     FirebaseLabelerOption(confidenceThreshold: 0.5, modelName: modelName);
    // _imageLabeler = ImageLabeler(options: options);

    _canProcess = true;
  }

  Future<void> _detectObject() async {
    if (_cameraManager.cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final pictureFile = await _cameraManager.cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);

      //final recognizedText = await textRecognizer.processImage(inputImage);
      final labels = await _imageLabeler.processImage(inputImage);
      for (final label in labels) {
        await navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ObjectResultScreen(text: label.label),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
