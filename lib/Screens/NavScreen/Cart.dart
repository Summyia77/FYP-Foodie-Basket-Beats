import 'package:flutter/material.dart';

import '../Home.dart';

void main() {
  runApp(Cart());
}

class Cart
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cart ',style: TextStyle(color: Colors.white),),
          backgroundColor: hexStringToColor("#FFA500"),
        ),
        body: Container(
          color:Colors.white,
          child: Center(
            child: Text(
              'Cart',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }
}
