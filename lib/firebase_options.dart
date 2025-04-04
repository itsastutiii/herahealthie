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
    apiKey: 'AIzaSyABiR0QarSbbTAEa0ujbwPESp_OofKK-Fc',
    appId: '1:280642195368:web:f08ffa9da7af625f57979d',
    messagingSenderId: '280642195368',
    projectId: 'herahealth-cdd6b',
    authDomain: 'herahealth-cdd6b.firebaseapp.com',
    storageBucket: 'herahealth-cdd6b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrpYVp2yxOWCL-4wP9uSJRKPoDbwMga9U',
    appId: '1:280642195368:android:6466f25b3fadb10e57979d',
    messagingSenderId: '280642195368',
    projectId: 'herahealth-cdd6b',
    storageBucket: 'herahealth-cdd6b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKqF3JJ-TxMibntRz9651qPxcETPDcU0o',
    appId: '1:280642195368:ios:2594e79e1445595957979d',
    messagingSenderId: '280642195368',
    projectId: 'herahealth-cdd6b',
    storageBucket: 'herahealth-cdd6b.firebasestorage.app',
    iosBundleId: 'com.example.herahealthie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKqF3JJ-TxMibntRz9651qPxcETPDcU0o',
    appId: '1:280642195368:ios:2594e79e1445595957979d',
    messagingSenderId: '280642195368',
    projectId: 'herahealth-cdd6b',
    storageBucket: 'herahealth-cdd6b.firebasestorage.app',
    iosBundleId: 'com.example.herahealthie',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyABiR0QarSbbTAEa0ujbwPESp_OofKK-Fc',
    appId: '1:280642195368:web:69bd4cea964a584657979d',
    messagingSenderId: '280642195368',
    projectId: 'herahealth-cdd6b',
    authDomain: 'herahealth-cdd6b.firebaseapp.com',
    storageBucket: 'herahealth-cdd6b.firebasestorage.app',
  );
}
