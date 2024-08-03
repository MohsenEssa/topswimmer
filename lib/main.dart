import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:topswimmer/login_page.dart';
import 'package:get/get.dart';

import 'auth/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization options for web
  const firebaseOptionsWeb = FirebaseOptions(
    apiKey: "AIzaSyDoUJxqnw7A7FfCtw-iJ_M6Ky1Lf6Us5mk",
    appId: "1:3474585180:web:72460d39586f1225265899",
    messagingSenderId: "3474585180",
    projectId: "topswimmerdb",
  );


  // Initialize Firebase based on the platform
  if (kIsWeb) {
    await Firebase.initializeApp(options: firebaseOptionsWeb).then((value) => Get.put(UserAuthController()));
  } else {
    await Firebase.initializeApp().then((value) => Get.put(UserAuthController()));
  }

  // Register AuthController with GetX
  Get.put(UserAuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}