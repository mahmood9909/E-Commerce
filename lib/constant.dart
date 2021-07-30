import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const TextStyle regularHeading = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle heading = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle buttonsText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle buttonsTextWithFalseOutLine = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);

  static const TextStyle inputTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);

  static const TextStyle cartItemsText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);

  static const TextStyle buttonsTextWhiteText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);

  TextStyle prcieText(BuildContext context) => TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).accentColor);
}
