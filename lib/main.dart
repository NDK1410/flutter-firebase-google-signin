import 'package:firebase_sign_in_google/screens/splashscreen.dart';
import 'package:firebase_sign_in_google/screens/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FaceBase',
    routes: routes,
    home: SplashScreen(),
  ));
}
