import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogService {
  Future<void> alertDialogBuilder(String? message, BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Container(child: Text(message.toString())),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("close"))
              ],
            ));
  }
}
