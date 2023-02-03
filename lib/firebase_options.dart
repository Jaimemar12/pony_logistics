// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC_-buckEsA3BW45ONFV4hRIXbcKBqd2Fw',
    appId: '1:348313600026:web:8a618a8263c6d8333991a3',
    messagingSenderId: '348313600026',
    projectId: 'pony-logistics',
    authDomain: 'pony-logistics.firebaseapp.com',
    storageBucket: 'pony-logistics.appspot.com',
    measurementId: 'G-TLV3LGD306',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAg9KXa-uLM-1fe8glR-lAAvq44cq3spPc',
    appId: '1:348313600026:android:cc7b5e8d013b07ef3991a3',
    messagingSenderId: '348313600026',
    projectId: 'pony-logistics',
    storageBucket: 'pony-logistics.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5vmEytsl3MqpWvll4rumdFymFRX5ihx4',
    appId: '1:348313600026:ios:6f5a249c7404a7f23991a3',
    messagingSenderId: '348313600026',
    projectId: 'pony-logistics',
    storageBucket: 'pony-logistics.appspot.com',
    androidClientId: '348313600026-ghh1h61ifvrl7rf00a5qu675k0n1sse4.apps.googleusercontent.com',
    iosClientId: '348313600026-ic11qkgq973ns06v21tfhvqmqtpts665.apps.googleusercontent.com',
    iosBundleId: 'com.pony.logitstics.ponyLogistics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5vmEytsl3MqpWvll4rumdFymFRX5ihx4',
    appId: '1:348313600026:ios:6f5a249c7404a7f23991a3',
    messagingSenderId: '348313600026',
    projectId: 'pony-logistics',
    storageBucket: 'pony-logistics.appspot.com',
    androidClientId: '348313600026-ghh1h61ifvrl7rf00a5qu675k0n1sse4.apps.googleusercontent.com',
    iosClientId: '348313600026-ic11qkgq973ns06v21tfhvqmqtpts665.apps.googleusercontent.com',
    iosBundleId: 'com.pony.logitstics.ponyLogistics',
  );
}
