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
    apiKey: 'AIzaSyDoUJxqnw7A7FfCtw-iJ_M6Ky1Lf6Us5mk',
    appId: '1:3474585180:web:72460d39586f1225265899',
    messagingSenderId: '3474585180',
    projectId: 'topswimmerdb',
    authDomain: 'topswimmerdb.firebaseapp.com',
    storageBucket: 'topswimmerdb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNXWquKVyPfkSp04CQuyaXO2N0rNpkB7I',
    appId: '1:3474585180:android:a41d5705127d88ee265899',
    messagingSenderId: '3474585180',
    projectId: 'topswimmerdb',
    storageBucket: 'topswimmerdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxV7jxxOUWiN_DjAPXNVxoxaJ9OJ8H8Fo',
    appId: '1:3474585180:ios:720029ba50328fcf265899',
    messagingSenderId: '3474585180',
    projectId: 'topswimmerdb',
    storageBucket: 'topswimmerdb.appspot.com',
    iosBundleId: 'com.example.topswimmerNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxV7jxxOUWiN_DjAPXNVxoxaJ9OJ8H8Fo',
    appId: '1:3474585180:ios:720029ba50328fcf265899',
    messagingSenderId: '3474585180',
    projectId: 'topswimmerdb',
    storageBucket: 'topswimmerdb.appspot.com',
    iosBundleId: 'com.example.topswimmerNew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDoUJxqnw7A7FfCtw-iJ_M6Ky1Lf6Us5mk',
    appId: '1:3474585180:web:1abf0bd790c6d148265899',
    messagingSenderId: '3474585180',
    projectId: 'topswimmerdb',
    authDomain: 'topswimmerdb.firebaseapp.com',
    storageBucket: 'topswimmerdb.appspot.com',
  );

}