import 'package:flutter/material.dart';

class LoadingProgressIndictaor extends StatelessWidget {
  final Color progressIndictorColor;
  LoadingProgressIndictaor({required this.progressIndictorColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: progressIndictorColor,
      ),
    );
  }
}
