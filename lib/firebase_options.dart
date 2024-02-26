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
    apiKey: 'AIzaSyD9cCYYrJ8sDJT6POotw24YefU0Lu2w8Aw',
    appId: '1:992903232594:web:dcda33dfc88424269b738b',
    messagingSenderId: '992903232594',
    projectId: 'push-notification-22a74',
    authDomain: 'push-notification-22a74.firebaseapp.com',
    storageBucket: 'push-notification-22a74.appspot.com',
    measurementId: 'G-L45RV34S0R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxUEmtUQzX7AkzSFJqIIWwfhxJjSiph1Q',
    appId: '1:992903232594:android:e6460d4019f78c499b738b',
    messagingSenderId: '992903232594',
    projectId: 'push-notification-22a74',
    storageBucket: 'push-notification-22a74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpclDqQCJZ_XYHkvVF6AAk10SZt5nGcX4',
    appId: '1:992903232594:ios:93b9abd7411ac4569b738b',
    messagingSenderId: '992903232594',
    projectId: 'push-notification-22a74',
    storageBucket: 'push-notification-22a74.appspot.com',
    iosBundleId: 'com.example.flutterPushNotification',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpclDqQCJZ_XYHkvVF6AAk10SZt5nGcX4',
    appId: '1:992903232594:ios:cb420184e6b107539b738b',
    messagingSenderId: '992903232594',
    projectId: 'push-notification-22a74',
    storageBucket: 'push-notification-22a74.appspot.com',
    iosBundleId: 'com.example.flutterPushNotification.RunnerTests',
  );
}
