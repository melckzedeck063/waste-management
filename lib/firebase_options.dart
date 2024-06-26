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
    apiKey: 'AIzaSyBcVkE3k3zxzKPu7bzdCVKWiqnTuh_rmss',
    appId: '1:732214225582:web:64665c4d609472eeb81b3f',
    messagingSenderId: '732214225582',
    projectId: 'waste-management-78154',
    authDomain: 'waste-management-78154.firebaseapp.com',
    storageBucket: 'waste-management-78154.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeK9hBDRPJPxDy05Q26JOYwgZHXgZ8vow',
    appId: '1:732214225582:android:5f41d9af9d1dc86db81b3f',
    messagingSenderId: '732214225582',
    projectId: 'waste-management-78154',
    storageBucket: 'waste-management-78154.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxEtkjpSXZ_PrNX-edIE45dAvrTSQKI3g',
    appId: '1:732214225582:ios:9dc4d31c5b26c54db81b3f',
    messagingSenderId: '732214225582',
    projectId: 'waste-management-78154',
    storageBucket: 'waste-management-78154.appspot.com',
    iosBundleId: 'com.example.manageWaste',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxEtkjpSXZ_PrNX-edIE45dAvrTSQKI3g',
    appId: '1:732214225582:ios:9dc4d31c5b26c54db81b3f',
    messagingSenderId: '732214225582',
    projectId: 'waste-management-78154',
    storageBucket: 'waste-management-78154.appspot.com',
    iosBundleId: 'com.example.manageWaste',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcVkE3k3zxzKPu7bzdCVKWiqnTuh_rmss',
    appId: '1:732214225582:web:d7f5ff82b39771ccb81b3f',
    messagingSenderId: '732214225582',
    projectId: 'waste-management-78154',
    authDomain: 'waste-management-78154.firebaseapp.com',
    storageBucket: 'waste-management-78154.appspot.com',
  );
}
