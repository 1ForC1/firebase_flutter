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
    apiKey: 'AIzaSyDjpKEADhoBuS9J0DIvXWf1w5nTwHiVYmo',
    appId: '1:770831031320:web:bbe9362f242c97458df76d',
    messagingSenderId: '770831031320',
    projectId: 'flutter-test-4e9e0',
    authDomain: 'flutter-test-4e9e0.firebaseapp.com',
    storageBucket: 'flutter-test-4e9e0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9nNGVAAXTnWAv96ZPRi_Bm0NLrA74WIQ',
    appId: '1:770831031320:android:40a26e18665d90388df76d',
    messagingSenderId: '770831031320',
    projectId: 'flutter-test-4e9e0',
    storageBucket: 'flutter-test-4e9e0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjrPIuNMuMle-PI-l8mkvnT2bZ1YFh3ZE',
    appId: '1:770831031320:ios:ddefc9859cc9294c8df76d',
    messagingSenderId: '770831031320',
    projectId: 'flutter-test-4e9e0',
    storageBucket: 'flutter-test-4e9e0.appspot.com',
    iosClientId: '770831031320-dtbl6p2le62dnsd714m7fk9nlkiui98o.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjrPIuNMuMle-PI-l8mkvnT2bZ1YFh3ZE',
    appId: '1:770831031320:ios:ddefc9859cc9294c8df76d',
    messagingSenderId: '770831031320',
    projectId: 'flutter-test-4e9e0',
    storageBucket: 'flutter-test-4e9e0.appspot.com',
    iosClientId: '770831031320-dtbl6p2le62dnsd714m7fk9nlkiui98o.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebase',
  );
}
