import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container reusablebutton(BuildContext context, bool islogin, Function onTap){

  return Container(
    width: 280,
    height: 40,
    margin:EdgeInsets.only(top:30),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){onTap();},
      child: Text(islogin? "LOGIN":"SIGN UP",
      style: const TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 12),
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
        if(states.contains(MaterialState.pressed)){
          return Colors.black26;
        }
        return Colors.black;
  }
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)))
      )
    ),
  );


}