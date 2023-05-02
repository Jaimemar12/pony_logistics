import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/firebase_options.dart';
import 'package:pony_logistics/src/constants/colors.dart';
import 'package:pony_logistics/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/admin_dashboard.dart';
import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';
import 'package:pony_logistics/src/repository/shared_preferences_repository/shared_preferences.dart';
import 'package:pony_logistics/src/repository/user_repository/user_repository.dart';
import 'package:pony_logistics/src/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

/// NOTE:
/// DESIGN PLAYLIST : https://www.youtube.com/playlist?list=PL5jb9EteFAODpfNJu8U2CMqKFp4NaXlto
/// FIREBASE PLAYLIST : https://www.youtube.com/playlist?list=PL5jb9EteFAOC9V6ZHAIg3ycLtjURdVxUH
/// For the Firebase setup You can watch this video - https://www.youtube.com/watch?v=fxDusoMcWj8

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  } else {
    getWindowInfo().then((window) {
      final screen = window.screen;
      if (screen != null) {
        final screenFrame = screen.visibleFrame;
        final width = max((screenFrame.width / 2).roundToDouble(), 800.0);
        final height = max((screenFrame.height / 2).roundToDouble(), 680.0);
        setWindowMinSize(Size(.8 * width, .8 * height));
        setWindowTitle('Pony Logistics');
      }
    });
  }

  if (Platform.isAndroid) {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: brightness == Brightness.light
          ? tPrimaryColor
          : tAccentColor, // change the color to your desired color
    ));
  }

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // if (!Platform.isWindows) {
  //   await Firebase.initializeApp(
  //           name: 'pony-logistics',
  //           options: DefaultFirebaseOptions.currentPlatform)
  //       .then((value) => Get.put(AuthenticationRepository()));
  // }
  await GoogleSheetsRepository.init();
  await SharedPreferencesRepository.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: isUserLoggedIn(),
    );
  }

  isUserLoggedIn() {
    SharedPreferencesRepository.getUserName().then((value) {
      if (value != null) {
        Get.to(() => AdminDashboard(), transition: Transition.noTransition);
      }
    });
    return WelcomeScreen();
  }
}
