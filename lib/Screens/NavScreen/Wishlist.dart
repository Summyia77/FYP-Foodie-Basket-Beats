import 'package:flutter/material.dart';
import '../Home.dart';

void main() {
  runApp(Wishlist());
}

class Wishlist
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wishlist ',style: TextStyle(color: Colors.white),),
          backgroundColor: hexStringToColor("#FFA500"),
        ),
        body: Container(
          color:Colors.white,
          child:Center(
            child: Text(
              'Wishlist',
              style: TextStyle(fontSize: 40),
            ),
          ),
        )
      ),
    );
  }
}
