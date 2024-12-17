import 'package:flutter/material.dart';
import 'package:fyp_project_1/Screens/Login.dart';
import 'package:fyp_project_1/Screens/SignIn.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with flexible sizing and content alignment
          Positioned.fill(
            child: Image.asset(
              "images/Welcome_Screen_bg.jpg", // Replace with your image path
              fit: BoxFit.cover,

              alignment: Alignment.center,
            ),
          ),

          // Black box with curved border covering half the screen
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 160, // Half the screen height
              decoration: BoxDecoration(
                color: Colors.black, // Semi-transparent black
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0), // Adjust as needed
                child: Center(
                  child: Text(
                    ''

                       ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ),
          ),

          // Add the logo with equal left-right distance
          // Positioned(
          //   top: 200.0,
          //   bottom: 10,
          //   // Adjust position as needed (y-axis from top)
          //   left: (MediaQuery.of(context).size.width - 160.0) / 2,
          //   child: SizedBox(
          //     height: 180.0, // Adjust logo size as desired
          //     width: 180.0, // Adjust logo size as desired
          //     child: CircleAvatar(
          //         radius: 24.0,
          //
          //         backgroundImage: AssetImage("images/icon.png")),
          //
          //   ),
          // ),

          // Add two ElevatedButtons positioned at the bottom with padding
          Positioned(
            bottom: 5.0, // Adjust padding from the bottom as needed
            left: 20.0, // Adjust padding from the left as needed
            right: 20.0, // Adjust padding from the right as needed
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              // Adjust padding values as desired
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space buttons evenly
                children: [


                  // Button 1 with Login navigation
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:EdgeInsets.only(top:5),
                      minimumSize: const Size(270, 40), // Adjust size as needed
                      backgroundColor: Colors.orange, // Set button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Button 2 with Sign In navigation
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    style: ElevatedButton.styleFrom(

                      minimumSize: const Size(269, 40), // Adjust size as needed
                     backgroundColor: Colors.transparent, // Set button background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.0),
                        side: BorderSide(color: Colors.orange, width: 2.0), // Add border
                      ),
                    ),
                    child: Text(
                      'Create An Account',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
