import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDtCimEbbr3uRUgVZYUGqPZPSEX_E5RIeM",
            authDomain: "terram-746e3.firebaseapp.com",
            projectId: "terram-746e3",
            storageBucket: "terram-746e3.appspot.com",
            messagingSenderId: "697961687935",
            appId: "1:697961687935:web:ccd854eef4d34eb5a1c84a",
            measurementId: "G-Q5HEQQW7E9"));
  } else {
    await Firebase.initializeApp();
  }
}
