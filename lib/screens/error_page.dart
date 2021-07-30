import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(),
          child: Text(
            "😑",
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
