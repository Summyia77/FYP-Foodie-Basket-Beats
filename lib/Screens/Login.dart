import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_1/Reuseable%20code/Credential_code.dart';
import 'package:fyp_project_1/Reuseable%20code/reusable_button.dart';
import "package:fyp_project_1/Screens/SignIn.dart";
import "package:fyp_project_1/Screens/Location.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Home.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => SignInState();
}

class SignInState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailtextcontroller=TextEditingController();
    TextEditingController  _passwordcontroller=TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
      child:Container(
        height: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#000000"), // Black color
              hexStringToColor("#FF9400"), // Slightly darker shade of orange
              hexStringToColor("#FFA500"), // Base orange color
              hexStringToColor("#FFB733"), // Lighter shade of orange
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 160.0), // Adjust top padding as needed
                child: Column(
                    children:<Widget>[Image.asset(
                      'images/icon.png', // Replace with your image path
                      width: 200, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
                    ),
                      reusabletextfield("Enter Email",Icons.person_outline, false, _emailtextcontroller),
                      reusabletextfield("Enter Password",Icons.lock_outline, true, _passwordcontroller),
                      reusablebutton(context, true, () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: _emailtextcontroller.text, password: _passwordcontroller.text)
                            .then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        }).catchError((error) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(error.toString()),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      })
                      ,signup()]
                ),
              ),
            ),
          ],
        ),
      ),
      ),);
  }
  Row signup(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top:8.0), // Adjufirst padding as needed
          child: Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
          },
          child: Padding(
            padding: EdgeInsets.only(top:8.0), // Adjust padding as needed
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

}

Color hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
