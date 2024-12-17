import 'dart:async';
import 'package:fyp_project_1/Screens/Welcome.dart';
import 'package:fyp_project_1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp_project_1/Screens/SignIn.dart';
import 'package:fyp_project_1/Screens/Login.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

    Center(
    child: Image.asset(
    'images/Splash_Screen_Img.jpg', // Example path to your JPEG image
    width: 400, // Optional: Adjust width as per your requirement
    height: 1000, // Optional: Adjust height as per your requirement
    fit: BoxFit.cover, // Optional: Adjust how the image is displayed
    ),),
    );
  }
}
