import 'dart:html';

import 'package:flutter/material.dart';

import '../../constant.dart';

class CartList extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final Function onPress;
  const CartList(
      {required this.image,
      required this.name,
      required this.price,
      required this.onPress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 300,
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  style: Constants.regularHeading,
                ),
                Text("$price BD", style: Constants().prcieText(context))
              ],
            ),
          )
        ],
      ),
    );
  }
}
