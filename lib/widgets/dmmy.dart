import 'package:flutter/material.dart';

class Called extends StatelessWidget {
  final Function toggle;
  const Called({required this.toggle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => toggle(),
        child: Text("Check"),
      ),
    );
  }
}
