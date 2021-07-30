import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorExceptions {
  Widget renderTheError() {
    return Center(
        child: Container(
      decoration: BoxDecoration(),
      child: Text(
        "😑",
        style: TextStyle(fontSize: 50.0),
      ),
    ));
  }
}
