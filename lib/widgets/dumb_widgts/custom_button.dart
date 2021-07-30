import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final bool outLineBtn;
  final bool isLoading;

  const CustomButton(
      {required this.text,
      required this.outLineBtn,
      required this.onPressed,
      required this.isLoading,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed!(),
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * 0.90,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
            color: outLineBtn ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12.0)),
        child: Stack(
          children: [
            !isLoading
                ? Center(
                    child: Text(
                      text,
                      style: outLineBtn
                          ? Constants.buttonsText
                          : Constants.buttonsTextWithFalseOutLine,
                    ),
                  )
                : Center(
                    child: SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: CircularProgressIndicator()),
                  )
          ],
        ),
      ),
    );
  }
}
