// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAXCtu4BtaMdFmkDCy4qTGRp4Uyh9pRVV4',
    appId: '1:224895673251:web:75a884f036a74d83c8f016',
    messagingSenderId: '224895673251',
    projectId: 'atm-app-ea255',
    authDomain: 'atm-app-ea255.firebaseapp.com',
    storageBucket: 'atm-app-ea255.firebasestorage.app',
    measurementId: 'G-F9VHY8TCF7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8FaTdSwy-_SiHEa3k7W0A1wSY7Q4ShDI',
    appId: '1:224895673251:android:a6dd93ade0a12b6dc8f016',
    messagingSenderId: '224895673251',
    projectId: 'atm-app-ea255',
    storageBucket: 'atm-app-ea255.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6qm68WW5EJ71lnUobyxSq3BaUCv_mSLc',
    appId: '1:224895673251:ios:53d8d7b8a0e71763c8f016',
    messagingSenderId: '224895673251',
    projectId: 'atm-app-ea255',
    storageBucket: 'atm-app-ea255.firebasestorage.app',
    iosBundleId: 'com.example.atmApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6qm68WW5EJ71lnUobyxSq3BaUCv_mSLc',
    appId: '1:224895673251:ios:53d8d7b8a0e71763c8f016',
    messagingSenderId: '224895673251',
    projectId: 'atm-app-ea255',
    storageBucket: 'atm-app-ea255.firebasestorage.app',
    iosBundleId: 'com.example.atmApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXCtu4BtaMdFmkDCy4qTGRp4Uyh9pRVV4',
    appId: '1:224895673251:web:60b42cfb06b0ee9ac8f016',
    messagingSenderId: '224895673251',
    projectId: 'atm-app-ea255',
    authDomain: 'atm-app-ea255.firebaseapp.com',
    storageBucket: 'atm-app-ea255.firebasestorage.app',
    measurementId: 'G-RV2H7ZSC1J',
  );
}
