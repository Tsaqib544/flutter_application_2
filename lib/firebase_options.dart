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
    apiKey: 'AIzaSyA9yl9-uAeQxwpwmpy6fbOdZDC8BJmXLBs',
    appId: '1:883481234086:web:5bdb641f9ebd6cd7ca0267',
    messagingSenderId: '883481234086',
    projectId: 'survei-dosen-dan-mata-kuliah',
    authDomain: 'survei-dosen-dan-mata-kuliah.firebaseapp.com',
    storageBucket: 'survei-dosen-dan-mata-kuliah.appspot.com',
    measurementId: 'G-4YYQXFTQZ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4qLoIYN1h9iGaYND_rcJZ2hOSP85gJME',
    appId: '1:883481234086:android:61b7460314f54687ca0267',
    messagingSenderId: '883481234086',
    projectId: 'survei-dosen-dan-mata-kuliah',
    storageBucket: 'survei-dosen-dan-mata-kuliah.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtg3Zzk3w53t7EHRH8E_bVSDqI4Ih2T9U',
    appId: '1:883481234086:ios:57b25b13165d2e99ca0267',
    messagingSenderId: '883481234086',
    projectId: 'survei-dosen-dan-mata-kuliah',
    storageBucket: 'survei-dosen-dan-mata-kuliah.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtg3Zzk3w53t7EHRH8E_bVSDqI4Ih2T9U',
    appId: '1:883481234086:ios:57b25b13165d2e99ca0267',
    messagingSenderId: '883481234086',
    projectId: 'survei-dosen-dan-mata-kuliah',
    storageBucket: 'survei-dosen-dan-mata-kuliah.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9yl9-uAeQxwpwmpy6fbOdZDC8BJmXLBs',
    appId: '1:883481234086:web:b22d985cf69a586eca0267',
    messagingSenderId: '883481234086',
    projectId: 'survei-dosen-dan-mata-kuliah',
    authDomain: 'survei-dosen-dan-mata-kuliah.firebaseapp.com',
    storageBucket: 'survei-dosen-dan-mata-kuliah.appspot.com',
    measurementId: 'G-VLQWRVMTKV',
  );
}
