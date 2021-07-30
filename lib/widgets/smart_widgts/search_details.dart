import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/dumb_widgts/cutome_input_field.dart';
import 'package:ecommerce/widgets/smart_widgts/products_list.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../error_widget.dart';
import '../loading_widget.dart';

class SearchDetails extends StatefulWidget {
  const SearchDetails({Key? key}) : super(key: key);

  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  final CollectionReference _productColleaction =
      FirebaseFirestore.instance.collection("products");

  String _searchText = "";

  bool isItEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomInputField(
            hintText: "Type Product Name",
            isItObosecure: false,
            onChange: (String val) {},
            onSubmit: (String searchText) {
              if (searchText.isEmpty) {
                setState(() {
                  isItEmpty = false;
                });
              } else {
                setState(() {
                  isItEmpty = true;
                  _searchText = searchText;
                });
              }
            },
          ),
          if (!isItEmpty) ...[
            Text(
              "Serach Result",
              style: Constants.regularHeading,
            ),
          ],
          if (isItEmpty) ...[
            FutureBuilder(
                future: _productColleaction
                    .where("name",
                        isGreaterThanOrEqualTo: _searchText.toLowerCase())
                    .where("name",
                        isLessThanOrEqualTo:
                            _searchText.toLowerCase() + '\uf8ff')
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) ErrorExceptions().renderTheError();

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.docs.length == 0) {
                      return Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sorry No availble products with the given name",
                              style: Constants.regularHeading,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ProductsList(
                              docsRef: snapshot.data!.docs[index]);
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  }

                  return Expanded(
                    child: Center(
                      child: Container(
                        child: LoadingProgressIndictaor(
                            progressIndictorColor:
                                Theme.of(context).accentColor),
                      ),
                    ),
                  );

                  // return Center(
                  //   child: CircularProgressIndicator(
                  //     color: Theme.of(context).accentColor,
                  //   ),
                  // );
                }),
          ]
        ],
      ),
    );
  }
}
