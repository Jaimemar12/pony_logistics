import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pony_logistics/src/constants/sizes.dart';
import 'package:pony_logistics/src/features/core/controllers/google_sheets_controller.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/admin_dashboard.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/result_screen.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/ship_package_screen.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/submit_package_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../repository/google_sheets_repository/google_sheets_repository.dart';
import 'components/drawer_menu.dart';
import 'components/responsive.dart';

class ScanPictureScreen extends StatefulWidget {
  ScanPictureScreen(this.screen, {Key? key}) : super(key: key);
  String screen;

  @override
  State<StatefulWidget> createState() {
    return _ScanPictureScreen(screen);
  }
}

class _ScanPictureScreen extends State<ScanPictureScreen>
    with WidgetsBindingObserver {
  _ScanPictureScreen(this.screen) : super();

  String screen;
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

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    try {
      final pictureFile = await _cameraController!.takePicture();

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pictureFile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: isDark ? tPrimaryColor : tAccentColor,
              toolbarWidgetColor: !isDark ? tPrimaryColor : tAccentColor,
              initAspectRatio: CropAspectRatioPreset.original,
              hideBottomControls: true,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Image',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile == null) {
        return;
      }

      final file = File(croppedFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      List<String> textList =
          recognizedText.text.removeAllWhitespace.split('\n');
      String partNumber = '';
      String caseNumber = textList[textList.length - 2];
      String quantity = textList[textList.length - 1].numericOnly();

      for (var element in textList) {
        if (element.numericOnly().isNumericOnly) {
          partNumber = element.numericOnly();
          break;
        }
      }

      imageCache.clear();
      if (screen == 'submit') {
        PackageModel package = PackageModel(
            containerName: '',
            partNumber: partNumber,
            caseNumber: caseNumber,
            quantity: quantity,
            dateReceived:
                DateFormat('MM/dd/yyyy').format(DateTime.now()).toString());
        Get.to(() => SubmitPackageScreen(package, 'submit'),
            transition: Transition.noTransition);
      } else {
        List<PackageModel> package =
            await GoogleSheetsRepository().getPackages(partNumber, caseNumber);
        Get.to(() => SubmitPackageScreen(package[0], 'ship'),
            transition: Transition.noTransition);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? tAccentColor
              : tPrimaryColor,
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: DrawerMenu(),
              ),
            Expanded(
              flex: 5,
              child: FutureBuilder(
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
                        backgroundColor: _isPermissionGranted
                            ? Colors.transparent
                            : (MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? tAccentColor
                                : tPrimaryColor),
                        body: (_isPermissionGranted && (Platform.isAndroid || Platform.isIOS))
                            ? Column(
                                children: [
                                  Expanded(child: Container()),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: appPadding, right: appPadding),
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: _scanImage,
                                        child: const Icon(Icons.camera),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: appPadding, right: appPadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Camera Permission Denied',
                                        textAlign: TextAlign.center,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(() => AdminDashboard(),
                                              transition:
                                                  Transition.noTransition);
                                        },
                                        child: Text('Return home'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
