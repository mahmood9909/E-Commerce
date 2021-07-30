import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    required this.hintText,
    required this.isItObosecure,
    required this.onChange,
    this.onSubmit,
    this.focusNode,
    this.textInputAction,
    Key? key,
  }) : super(key: key);
  final String hintText;
  final bool isItObosecure;
  final Function(String) onChange;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .07,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Color(0XFFF2F2F2)),
      child: TextFormField(
        onChanged: onChange,
        focusNode: focusNode,
        onFieldSubmitted: onSubmit,
        obscureText: isItObosecure,
        textInputAction: textInputAction,
        cursorHeight: MediaQuery.of(context).size.height * .03,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0)),
        style: Constants.inputTextStyle,
      ),
    );
  }
}
