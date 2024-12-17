import 'package:flutter/material.dart';

void main() {
  runApp(Location());
}

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Text("location")
      ),
    );
  }
}
