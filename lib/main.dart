//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:topswimmer/login_page.dart';
import 'package:get/get.dart';

import 'auth/auth_controller.dart';

//Routing: Get provides a simple and intuitive way to handle navigation between screens in your application.
//It also provides some useful features like named routes and arguments.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //to make sure that the app is initialized before continuing with the rest of the code.
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  //initializes Firebase using Firebase.initializeApp() and waits for it
  //to complete using the await keyword. Once the initialization is complete,
  //it creates an instance of AuthController and registers it with
  //the GetX dependency injection system using Get.put(AuthController()).
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //we used GetMaterialApp instead of MaterialApp
      //because GetMaterialApp provides some useful features like named routes and arguments.
      //and that handle navigation between screens in your application.

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
