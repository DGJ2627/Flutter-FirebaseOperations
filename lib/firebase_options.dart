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
    apiKey: 'AIzaSyCVW2cHu_22-92d1e2-GVmGC6jTitQ7JO8',
    appId: '1:888397055893:web:6d650a92ae1b80eb56189c',
    messagingSenderId: '888397055893',
    projectId: 'flutter-firebase-operati-b9101',
    authDomain: 'flutter-firebase-operati-b9101.firebaseapp.com',
    storageBucket: 'flutter-firebase-operati-b9101.appspot.com',
    measurementId: 'G-BXVTB5TGHD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFCFnu52KkQ0b6CeNaMyOxo6OyMm8CsHs',
    appId: '1:888397055893:android:a078cd5c4442969556189c',
    messagingSenderId: '888397055893',
    projectId: 'flutter-firebase-operati-b9101',
    storageBucket: 'flutter-firebase-operati-b9101.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5UrU4HtcjUUeqkEvsgQhitAN05oYeYyo',
    appId: '1:888397055893:ios:d33f2f8e74294f1e56189c',
    messagingSenderId: '888397055893',
    projectId: 'flutter-firebase-operati-b9101',
    storageBucket: 'flutter-firebase-operati-b9101.appspot.com',
    androidClientId: '888397055893-ggc0b17ekfbd3ilf324db268or0bb9sk.apps.googleusercontent.com',
    iosClientId: '888397055893-2u7m94mcss9kihhvv91bp47gb2qpgg5e.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasaePushNotification2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5UrU4HtcjUUeqkEvsgQhitAN05oYeYyo',
    appId: '1:888397055893:ios:d33f2f8e74294f1e56189c',
    messagingSenderId: '888397055893',
    projectId: 'flutter-firebase-operati-b9101',
    storageBucket: 'flutter-firebase-operati-b9101.appspot.com',
    androidClientId: '888397055893-ggc0b17ekfbd3ilf324db268or0bb9sk.apps.googleusercontent.com',
    iosClientId: '888397055893-2u7m94mcss9kihhvv91bp47gb2qpgg5e.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasaePushNotification2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCVW2cHu_22-92d1e2-GVmGC6jTitQ7JO8',
    appId: '1:888397055893:web:989c0e89d53cdae856189c',
    messagingSenderId: '888397055893',
    projectId: 'flutter-firebase-operati-b9101',
    authDomain: 'flutter-firebase-operati-b9101.firebaseapp.com',
    storageBucket: 'flutter-firebase-operati-b9101.appspot.com',
    measurementId: 'G-6ZBCRCVEZ0',
  );
}
