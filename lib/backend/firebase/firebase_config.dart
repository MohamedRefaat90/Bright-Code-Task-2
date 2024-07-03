import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBHKZskdpiVeAJhvZcBR8qyN8tjj9j1kNM",
            authDomain: "test-brightcode.firebaseapp.com",
            projectId: "test-brightcode",
            storageBucket: "test-brightcode.appspot.com",
            messagingSenderId: "717810590309",
            appId: "1:717810590309:web:e1442259e8d8db21719c8c"));
  } else {
    await Firebase.initializeApp();
  }
}
