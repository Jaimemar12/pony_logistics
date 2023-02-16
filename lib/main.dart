import 'dart:math';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/firebase_options.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/admin_dashboard.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/style/colors.dart';
import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';
import 'package:pony_logistics/src/repository/user_repository/user_repository.dart';
import 'package:pony_logistics/src/utils/theme/theme.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

/// NOTE:
/// DESIGN PLAYLIST : https://www.youtube.com/playlist?list=PL5jb9EteFAODpfNJu8U2CMqKFp4NaXlto
/// FIREBASE PLAYLIST : https://www.youtube.com/playlist?list=PL5jb9EteFAOC9V6ZHAIg3ycLtjURdVxUH
/// For the Firebase setup You can watch this video - https://www.youtube.com/watch?v=fxDusoMcWj8

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid || Platform.isIOS){
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  } else {
    getWindowInfo().then((window) {
      final screen = window.screen;
      if (screen != null){
        final screenFrame = screen.visibleFrame;
        final width = max((screenFrame.width / 2).roundToDouble(), 800.0);
        final height = max((screenFrame.height / 2).roundToDouble(), 680.0);
        setWindowMinSize(Size(.8 * width, .8 * height));
        setWindowTitle('Pony Logistics');
      }
    });
  }

  /// Show Splash Screen till data loads & when load call FlutterNativeSplash.remove();
  /// In this case I'm removing it inside AuthenticationRepository() -> onReady() method.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Before running App - Initialize Firebase and after initialization call
  /// Authentication Repository so that It can check which screen to show.
  await Firebase.initializeApp(
          name: 'pony-logistics',
          options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  await PackageRepository.init();
  await UserRepository.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       scaffoldBackgroundColor: AppColors.primaryBg
    //   ),
    //   home: AdminDashboard(),
    // );
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
