import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/dumb_widgts/app_bar/cutsom_app_bar.dart';
import 'package:ecommerce/widgets/error_widget.dart';
import 'package:ecommerce/widgets/loading_widget.dart';
import 'package:ecommerce/widgets/smart_widgts/products_list.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);
  final CollectionReference _productColleaction =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          hasBackArrow: false,
          title: "Home",
          hasCartContainer: true,
          hasBackground: true,
        ),
        FutureBuilder(
            future: _productColleaction.get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) ErrorExceptions().renderTheError();

              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ProductsList(docsRef: snapshot.data!.docs[index]);
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                );
              }

              return Expanded(
                child: Center(
                  child: Container(
                    child: LoadingProgressIndictaor(
                        progressIndictorColor: Theme.of(context).accentColor),
                  ),
                ),
              );

              // return Center(
              //   child: CircularProgressIndicator(
              //     color: Theme.of(context).accentColor,
              //   ),
              // );
            }),
      ],
    );
  }
}
