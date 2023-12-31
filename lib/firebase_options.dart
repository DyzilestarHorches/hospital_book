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
    apiKey: 'AIzaSyB5thWwDy70HuR0d-xJvojrRiR_jgDcpOQ',
    appId: '1:691494936154:web:78eaf7152ebb6687e70263',
    messagingSenderId: '691494936154',
    projectId: 'hospital-book-5863a',
    authDomain: 'hospital-book-5863a.firebaseapp.com',
    storageBucket: 'hospital-book-5863a.appspot.com',
    measurementId: 'G-MR7RRFW8JT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEPwFb1jI-IP4JGgQWGvdoojFpbGo0FTI',
    appId: '1:691494936154:android:87a2b5ced4b6cf67e70263',
    messagingSenderId: '691494936154',
    projectId: 'hospital-book-5863a',
    storageBucket: 'hospital-book-5863a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa_ECgu9Uwy4-Cpw9MdM5cFf8qzPeRreY',
    appId: '1:691494936154:ios:9929e75011a9ad40e70263',
    messagingSenderId: '691494936154',
    projectId: 'hospital-book-5863a',
    storageBucket: 'hospital-book-5863a.appspot.com',
    iosClientId: '691494936154-ouvgcpuk53okm1ajmovf48ok5abs12io.apps.googleusercontent.com',
    iosBundleId: 'com.example.hospitalBooking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBa_ECgu9Uwy4-Cpw9MdM5cFf8qzPeRreY',
    appId: '1:691494936154:ios:949c781c3e717e9ae70263',
    messagingSenderId: '691494936154',
    projectId: 'hospital-book-5863a',
    storageBucket: 'hospital-book-5863a.appspot.com',
    iosClientId: '691494936154-1oiiujh42me3r2d7tem4oimho6h8mbdh.apps.googleusercontent.com',
    iosBundleId: 'com.example.hospitalBooking.RunnerTests',
  );
}
