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
    apiKey: 'AIzaSyDRise8Uj-pw_ishC06lgBlSVpSY-jTVEU',
    appId: '1:120886362643:web:85154459460c51b4d075e6',
    messagingSenderId: '120886362643',
    projectId: 'strony-internetowe-989ea',
    authDomain: 'strony-internetowe-989ea.firebaseapp.com',
    storageBucket: 'strony-internetowe-989ea.appspot.com',
    measurementId: 'G-EKLEEZHB9E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBng1kJyuqi0pv5MUJJ_GmyUzVjx4VnInc',
    appId: '1:120886362643:android:680f562969b5e903d075e6',
    messagingSenderId: '120886362643',
    projectId: 'strony-internetowe-989ea',
    storageBucket: 'strony-internetowe-989ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPxDuRamspLK1Xzszl6T9YwhVPURT8vls',
    appId: '1:120886362643:ios:1f6dff715aebc686d075e6',
    messagingSenderId: '120886362643',
    projectId: 'strony-internetowe-989ea',
    storageBucket: 'strony-internetowe-989ea.appspot.com',
    iosBundleId: 'com.example.sklepStronyInternetowe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPxDuRamspLK1Xzszl6T9YwhVPURT8vls',
    appId: '1:120886362643:ios:ceedcae1437042d8d075e6',
    messagingSenderId: '120886362643',
    projectId: 'strony-internetowe-989ea',
    storageBucket: 'strony-internetowe-989ea.appspot.com',
    iosBundleId: 'com.example.sklepStronyInternetowe.RunnerTests',
  );
}
