import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_1/Reuseable%20code/Credential_code.dart'; // Replace with actual path
import 'package:fyp_project_1/Reuseable%20code/reusable_button.dart'; // Replace with actual path
import 'Home.dart'; // Replace with actual path

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  TextEditingController _emailtextcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _usernametextcontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController();
  TextEditingController _dateofbirthcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("#000000"),
                hexStringToColor("#FF9400"),
                hexStringToColor("#FFA500"),
                hexStringToColor("#FFB733"),
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
                  padding: const EdgeInsets.only(top: 140.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/icon.png', // Replace with your image path
                        width: 200,
                        height: 200,
                      ),
                      reusabletextfield(
                          "Enter Username", Icons.person_outline, false, _usernametextcontroller),
                      reusabletextfield(
                          "Enter Email", Icons.email_outlined, false, _emailtextcontroller),
                      reusabletextfield(
                          "Enter Phone Number", Icons.phone, false, _numbercontroller),
                      reusabletextfield(
                          "Enter Password", Icons.lock_outline, true, _passwordcontroller),
                      reusabletextfield(
                          "Enter DOB", Icons.date_range, false, _dateofbirthcontroller),
                      reusablebutton(
                          context, false, () async {
                        await FirebaseFirestore.instance.collection('Users').add({
                          'email': _emailtextcontroller.text,
                          'password': _passwordcontroller.text, // Consider hashing the password
                          'phone': _numbercontroller.text,
                          'username': _usernametextcontroller.text,
                          'DOB': _dateofbirthcontroller.text,

                        });


                        //create user

                          UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                            email: _emailtextcontroller.text,
                            password: _passwordcontroller.text,
                          );
//add user details



                            // Clear text fields after successful signup
                            _emailtextcontroller.clear();
                            _passwordcontroller.clear();
                            _usernametextcontroller.clear();
                            _numbercontroller.clear();
                            _dateofbirthcontroller.clear();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }

                   )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
