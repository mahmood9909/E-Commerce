import 'package:flutter/material.dart';

import '../constant.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Loading....",
        style: Constants.regularHeading,
      ),
    ));
  }
}
