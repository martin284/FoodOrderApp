import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  VoidCallback onPressed;

  CustomButton(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: onPressed,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
      shape: RoundedRectangleBorder(
          side: BorderSide(), borderRadius: BorderRadius.circular(8)),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed
    );
  }
}
