import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCvTW-avpuyXaQujrnG8Im887RrrdcGSkw",
            authDomain: "bydgoszcz-k-a-s-5nyzet.firebaseapp.com",
            projectId: "bydgoszcz-k-a-s-5nyzet",
            storageBucket: "bydgoszcz-k-a-s-5nyzet.firebasestorage.app",
            messagingSenderId: "720750049340",
            appId: "1:720750049340:web:6a7cf3a10590f79d80ab39"));
  } else {
    await Firebase.initializeApp();
  }
}
