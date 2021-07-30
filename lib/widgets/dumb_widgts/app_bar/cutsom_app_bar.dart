import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens/cart_page.dart';
import 'package:ecommerce/service/db.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool hasBackArrow;
  final bool hasCartContainer;
  final bool hasBackground;
  final bool? isItCart;
  CustomAppBar(
      {this.title,
      required this.hasBackArrow,
      required this.hasCartContainer,
      required this.hasBackground,
      this.isItCart,
      Key? key})
      : super(key: key);
  DBServices _db = DBServices();
  final CollectionReference _user =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          color: hasBackground ? Colors.white.withOpacity(0.9) : null,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (hasBackArrow) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: constraints.maxWidth * 0.1,
                      height: constraints.maxWidth * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 15.0,
                      ))),
                )
              ],
              if (title != null) ...[Text(title!, style: Constants.heading)],
              if (hasCartContainer) ...[
                GestureDetector(
                  onTap: () {
                    if (isItCart != null || isItCart == true) {
                      return;
                    }
                    Navigator.of(context).pushNamed(CartPage.routName);
                  },
                  child: Container(
                      width: constraints.maxWidth * 0.1,
                      height: constraints.maxWidth * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                          child: StreamBuilder(
                              stream: _user
                                  .doc(_db.getCureentUserID)
                                  .collection("cart")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                return Text("${snapshot.data!.docs.length}",
                                    style: Constants.cartItemsText);
                              }))),
                )
              ]
            ],
          ),
          padding: EdgeInsets.only(
              top: constraints.maxWidth * 0.02,
              left: constraints.maxWidth * 0.05,
              right: constraints.maxWidth * 0.05));
    });
  }
}
