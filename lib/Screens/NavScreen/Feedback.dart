import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Login.dart';

void main() {
  runApp(Feedbackk());
}

class Feedbackk extends StatelessWidget {
  final currentUser = FirebaseAuth.instance;
  final firestore =
      FirebaseFirestore.instance.collection('Feedback').snapshots();
  TextEditingController _feedbackcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Feedback', style: TextStyle(color: Colors.white)),
          backgroundColor: hexStringToColor("#FFA500"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 200,
                    child: Lottie.asset(
                      "Animations/feeback_animation.json",
                      width: 400, // Adjust this value to change the width
                      height: 400, // Adjust this value to change the height
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where('email',
                            isEqualTo: currentUser.currentUser!.email)
                        .snapshots(),
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
                              final username =
                                  snapshot.data!.docs[index]['username'];

                              return Column(
                                children: [
                                  Center(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        "Hey! " + username,
                                        style: const TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        "Just give us your feedback about app",
                                        style: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.orange),
                                      ),
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

                  // **Position TextField below text**
                  Padding(
                    padding: const EdgeInsets.only(bottom: 98.0),
                    child: Container(
                      width: 300,
                      height: 130,
                      color: Colors.white,
                      child: TextField(
                        controller: _feedbackcontroller,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Enter your feedback',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color:
                                Colors.grey, // Set label text color to orange
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange, // Set border color to blue
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Submit button (optional)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('Feedback')
                              .add({
                            'feedback': _feedbackcontroller
                                .text, // Get the text from the controller
                          });
                          //dialog box
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('Feedback Status'),
                                    content: Text(
                                        'Your feedback has been successfully send.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('OK'),
                                      )
                                    ]);
                              });
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hexStringToColor("#FFA500"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
