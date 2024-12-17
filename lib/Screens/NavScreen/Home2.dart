import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Assuming you have these files with data retrieval logic
import '../../Reuseable code/Credential_code.dart';
import '../../Reuseable code/profile_data.dart';
// You might need to create this file
import '../../Reuseable code/search_data.dart'; // Or define the function here
import '../Login.dart';

void main() {
  runApp(Home2());
}

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final TextEditingController _usersearch = TextEditingController();
  String userInput = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChildScrollView(
        child: Container(
          height: 800,
          child: Scaffold(
            body: Stack(
                  children: [
                    // Gradient background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            hexStringToColor("#FFA500"),
                            hexStringToColor("#FFA500")
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40,
                        left: 20,
                        child: Column(
                          children: [
                            Text("Foodie Basket Beats",style: TextStyle(fontSize: 23,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.white),),
        
                            Text("Yummy Soltions For Your Hunger",style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,color: Colors.white),),
                          ],
                        )),
                    Positioned(
                      top: 20,
                      right: 0,
                      child: Container(
                        child: Lottie.asset(
                          "Animations/home_animation.json",
                          repeat:true,
                          width: 100, // Adjust this value to change the width
                          height: 100, // Adjust this value to change the height
                        ),
                      ),
                    ),
                    // Search input positioned on top
                    Positioned(
                      top: 130.0, // Adjust top padding as needed
                      left: 20.0, // Adjust left padding as needed
                      right: 20.0,
                      // Adjust right padding as needed
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10.0), // Adjust border radius
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Align icons at opposite ends
                          children: [
                            const SizedBox(width: 16.0
                            ,height: 14,), // Spacing before text
        
                            Expanded(
                              child: TextField(
                                controller: _usersearch,
                                onChanged: (text) {
                                  setState(() {
                                    userInput = text;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Search here..",
        
                                  border: InputBorder
                                      .none, // Remove default border for cleaner look
                                ),
                              ),
                            ),
        
                            const SizedBox(width: 8.0), // Spacing after text
        
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: hexStringToColor("#FFA500"),
                              ),
                              onPressed: () {
                                // Trigger search with userInput
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // White bottom container with rounded corners
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 610,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 9.0),
                            child: Column(
                              children: [
                                // Display retrieved data here (replace with actual data display logic)
                                Padding(
                                  padding: const EdgeInsets.only(top:15.0 ,bottom: 15),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: userInput.isEmpty
                                              ? 'Explore Food here'
                                              : ' Delicious ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:  _usersearch.text.trim(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange, // Replace with your desired color
                                          ),
                                        ),
                                        TextSpan(
                                          text: userInput.isEmpty ? '' : ' items here for you',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                fetchStoreData(category: _usersearch.text.trim().toLowerCase()),                                // _usersearch.text
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Recommended Food Items",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
        
          ),
        ),
      ),
    );
  }
}
