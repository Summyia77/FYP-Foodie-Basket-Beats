import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project_1/Screens/Welcome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file/cross_file.dart'; // If keeping both packages
import 'package:fyp_project_1/Reuseable code/profile_data.dart';

import '../Login.dart';
import 'Feedback.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  XFile? imageFile; // Use XFile (preferred for cross-platform compatibility)
  final firestore = FirebaseFirestore.instance.collection('Users').snapshots();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }


  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Foodie Basket Beats',style: TextStyle(color: Colors.white),),
            backgroundColor: hexStringToColor("#FFA500"),

        ),
         body: SingleChildScrollView(
      child: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Untitled design (2).jpg'),
              fit: BoxFit.cover,
            // Adjust the fit as needed
          ),
        ),
      // Apply blue background color

            height: 600.0, // Adjust height as needed
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),

                      child:CircleAvatar(
                      backgroundColor: hexStringToColor("#FFA500"),
                        radius: 40.0,
                        backgroundImage: AssetImage("images/icon.png")),),
                    Positioned(
                      bottom: 5.0,
                      right: 4.0,
                      child: InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (builder) => bottomtaparea(),
                        ),
                        child: Icon(
                          Icons.photo_camera_sharp,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Users").where('email',isEqualTo: currentUser?.email).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Handle error state
                    } else if (snapshot.hasData) {
                      final documents = snapshot.data!.docs;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            final username = snapshot.data!.docs[index]['username'];
                            final email = snapshot.data!.docs[index]['email'];
                            final phone = snapshot.data!.docs[index]['phone'];

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Column(  // Use Column here to nest child widgets
                                    children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 128.0),
                                    child: Row(
                                      children: [
                                        Text("Edit"),
                                        IconButton(
                                        onPressed: () {
                                                                    update(context, documents[index]);
                                                                    },

                                                                    icon: Icon(Icons.edit,color: Colors.orange,size: 20,),

                                                                    ),
                                      ],
                                    ),
                                  ),
                                     Text(username ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      Text(email),

                                                Text(phone)

                                      ,

                                      ElevatedButton(
                                        onPressed: () async {
                                          await sendPasswordResetEmail();
                                          // Handle success or failure, e.g., show a snackbar or dialog
                                        },
                                        child: Text('Reset Password' ,style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:2.0),
                                        child: ElevatedButton(
                                          onPressed: ()  {

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Feedbackk()),
                                            );
                                          },
                                          child: Text('Feedback' ,style: TextStyle(color: Colors.white),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: hexStringToColor("#FFA500"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(); // Handle loading state
                    }
                  },
                ),
                // Logout button

                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    print("Successfully Logout");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                  child: Text('Logout' ,style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomtaparea() {
    return Container(
      height: 130,
      width: 500,
      child: Column(
        children: [
          Text("Choose Profile Photo"),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  takeimg(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'), // Clearer label
              ),
              TextButton.icon(
                onPressed: () {
                  takeimg(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'), // Clearer label
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takeimg(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      imageFile = pickedFile;
    });
  }

  void update(BuildContext context, DocumentSnapshot<Object?> doc) async {
    final phonecontroller = TextEditingController(text: doc['phone']);
    final usernamecontroller = TextEditingController(text: doc['username']);
    final passwordcontroller = TextEditingController(text: doc['password']);
    final emailcontroller = TextEditingController(text: doc['email']);



    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: usernamecontroller,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),

                  TextFormField(
                    controller: phonecontroller,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),


                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                usernamecontroller.text = doc['username'];
                emailcontroller.text = doc['email'];
                phonecontroller.text = doc['phone'];



                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(doc.id)
                      .update({
                    'username': usernamecontroller.text,
                    'phone': phonecontroller.text,
                    'email': emailcontroller.text,


                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendPasswordResetEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);

        // Show confirmation popup on successful email sending
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text('A password reset link has been sent to your email address: ${user.email}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        // Handle errors, e.g., show an error message to the user
        print('Error sending password reset email: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error Sending Password Reset Email'),
            content: Text('Unautherized Email you use .so no email send '),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Handle the case where the user is not signed in
      print('User is not signed in.');
    }
  }
}
