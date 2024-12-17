import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/Login.dart';

Widget profiledata(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 5.0),
    child: Container(
      height: 37.0,
      width: 300.0,

      child: Row(
        children: [
          const SizedBox(width: 16.0),
          Icon(icon, color: hexStringToColor("#FFA500")),
          const SizedBox(width: 8.0),
          SingleChildScrollView(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
    ),
  );
}