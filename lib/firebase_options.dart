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
    apiKey: 'AIzaSyC5enWt6atxyIBfX0eQEqP3rJocKBolb28',
    appId: '1:475920844811:web:9fae1b7b4c753c84989f0e',
    messagingSenderId: '475920844811',
    projectId: 'festive-fusion-f4ba2',
    authDomain: 'festive-fusion-f4ba2.firebaseapp.com',
    storageBucket: 'festive-fusion-f4ba2.appspot.com',
    measurementId: 'G-ZHEZD0B09N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAyFgbGN5HBGjFLhn_LSdrC2Bqb2q86AT8',
    appId: '1:475920844811:android:cf1a869f805e12d8989f0e',
    messagingSenderId: '475920844811',
    projectId: 'festive-fusion-f4ba2',
    storageBucket: 'festive-fusion-f4ba2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOfKbBlurvWirrh0_B5Mt_zgWMgwgXaxo',
    appId: '1:475920844811:ios:d9f8e1ea0f1293ab989f0e',
    messagingSenderId: '475920844811',
    projectId: 'festive-fusion-f4ba2',
    storageBucket: 'festive-fusion-f4ba2.appspot.com',
    iosBundleId: 'com.example.festiveFusion',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOfKbBlurvWirrh0_B5Mt_zgWMgwgXaxo',
    appId: '1:475920844811:ios:51eb6d8b0701b0f3989f0e',
    messagingSenderId: '475920844811',
    projectId: 'festive-fusion-f4ba2',
    storageBucket: 'festive-fusion-f4ba2.appspot.com',
    iosBundleId: 'com.example.festiveFusion.RunnerTests',
  );
}
