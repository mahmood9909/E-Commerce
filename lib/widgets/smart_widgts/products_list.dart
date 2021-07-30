import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/details_page.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class ProductsList extends StatelessWidget {
  final DocumentSnapshot docsRef;
  const ProductsList({required this.docsRef, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailsPage.routName, arguments: docsRef.id);
      },
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
                docsRef.get("images")[0],
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
                  docsRef.get("name"),
                  style: Constants.regularHeading,
                ),
                Text("${docsRef.get("price") ?? "Not Avaialble"} BD",
                    style: Constants().prcieText(context))
              ],
            ),
          )
        ],
      ),
    );
  }
}
