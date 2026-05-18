// STUB: Run `flutterfire configure --platforms=web` to replace this file.
// Until then, Firebase features (email waitlist) will not work.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    throw UnsupportedError('No Firebase options for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAl7RNd4GZo-lyd0s_MeXAgqkcSWWrslag',
    appId: '1:255595089158:web:6e8b0d67b4eac3eef62287',
    messagingSenderId: '255595089158',
    projectId: 'your-days-4aad4',
    authDomain: 'your-days-4aad4.firebaseapp.com',
    storageBucket: 'your-days-4aad4.firebasestorage.app',
    measurementId: 'G-CXSWB1F3TW',
  );

}