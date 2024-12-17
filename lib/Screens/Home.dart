import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'NavScreen/Cart.dart';
import 'NavScreen/Home2.dart';

import 'NavScreen/Feedback.dart';

import 'NavScreen/Profile.dart';
import 'NavScreen/Wishlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  List<Widget> _screens = [Home2(),Cart(), Wishlist(), Profile()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // Efficiently switch between screens
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        color: hexStringToColor("#FFA500"), // Adjust color preference
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        height: 50, // Set custom height

        items: [
          Icon(Icons.home, size: 20, color: Colors.white),
          Icon(Icons.shopping_basket, size: 20, color: Colors.white),
          Icon(Icons.star, size: 20, color: Colors.white),
          Icon(Icons.person, size: 20, color: Colors.white),
        ],

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}Color hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    int value = int.parse(hexColor, radix: 16);
    return Color(value + 0xFF000000);
  } else {
    return Colors.white;
  }
}