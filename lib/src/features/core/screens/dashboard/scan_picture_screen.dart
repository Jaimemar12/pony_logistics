import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pony_logistics/src/constants/sizes.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/result_screen.dart';

import 'components/drawer_menu.dart';

class ScanPictureScreen extends StatefulWidget {
  const ScanPictureScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScanPictureScreen();
  }
}

class _ScanPictureScreen extends State<ScanPictureScreen>
    with WidgetsBindingObserver {
  _ScanPictureScreen() : super();

  bool _isPermissionGranted = false;
  late final Future<void> getPermission;
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    getPermission = _requestCameraPermission();
    super.initState();
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;
    for (CameraDescription currentCamera in cameras) {
      if (currentCamera.lensDirection == CameraLensDirection.back) {
        camera = currentCamera;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);

    await _cameraController?.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;
    
    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      Get.to( () {
        ResultScreen(text: recognizedText.text);
      }, transition: Transition.noTransition);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPermission,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(
                      child: CameraPreview(_cameraController!),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              backgroundColor: _isPermissionGranted ? Colors.transparent : null,
              body: _isPermissionGranted ? Column(
                children: [
                  Expanded(child: Container()),
                  Container(padding: EdgeInsets.only(left: appPadding, right: appPadding),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _scanImage, child: const Icon(Icons.camera),
                    ),
                  ),)
                ],
              ) : Center(
                child: Container(
                  padding: EdgeInsets.only(left: appPadding, right: appPadding),
                  child: Text('Camera Permission Denied',
                  textAlign: TextAlign.center,),
                ),
              ),
            )
          ],
        );

      },
    );
  }
}
