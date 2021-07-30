import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarServices {
  void buildSnackBar(BuildContext context, Function todo, Color bgColor,
      String text, String labelText) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bgColor,
      content: Text(text),
      action: SnackBarAction(
        label: labelText,
        textColor: Colors.white,
        onPressed: () => todo(),
      ),
    ));
  }
}
