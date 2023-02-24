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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB9Encf8Au5JS1hZc3Oxkf-q-z_L8POdK8',
    appId: '1:231904401577:web:caa6f6f90e0b2df25af1b8',
    messagingSenderId: '231904401577',
    projectId: 'tiktokclone-ad5e4',
    authDomain: 'tiktokclone-ad5e4.firebaseapp.com',
    storageBucket: 'tiktokclone-ad5e4.appspot.com',
    measurementId: 'G-0M968JQXVJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAk-jG1aHVj4kz1dgvHbt67pnnkADHvapc',
    appId: '1:231904401577:android:9755f0df3ff973d45af1b8',
    messagingSenderId: '231904401577',
    projectId: 'tiktokclone-ad5e4',
    storageBucket: 'tiktokclone-ad5e4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc15_JWSEs6njPxLK72CVGU2r0w2RRPz4',
    appId: '1:231904401577:ios:bb56a47854c933fb5af1b8',
    messagingSenderId: '231904401577',
    projectId: 'tiktokclone-ad5e4',
    storageBucket: 'tiktokclone-ad5e4.appspot.com',
    iosClientId: '231904401577-egqmkust36vpvvnfc2hqvrn9hpa1ikl1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktok',
  );
}
