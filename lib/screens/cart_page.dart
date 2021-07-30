import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/service/db.dart';
import 'package:ecommerce/widgets/dumb_widgts/app_bar/cutsom_app_bar.dart';
import 'package:ecommerce/widgets/error_widget.dart';
import 'package:ecommerce/widgets/loading_widget.dart';
import 'package:ecommerce/widgets/smart_widgts/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  static const routName = "cart-page";
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DBServices _db = DBServices();
  @override
  Widget build(BuildContext context) {
    int time = 800;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              hasBackArrow: true,
              hasCartContainer: true,
              hasBackground: false,
              title: "Cart",
              isItCart: true,
            ),
            FutureBuilder(
                future: _db.userCartCollection().get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) ErrorExceptions().renderTheError();

                  if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("products")
                                  .doc(snapshot.data!.docs[index].id)
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> proSnap) {
                                if (proSnap.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (proSnap.hasData && !proSnap.data!.exists) {
                                  return Text("Document does not exist");
                                }
                                if (proSnap.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data = proSnap.data!
                                      .data() as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 24.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "${data['images'][0]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data['name']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                ),
                                                child: Text(
                                                  "\$${data['price']}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                "Size - ${snapshot.data!.docs[index]['size']}",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Shimmer.fromColors(
                                      highlightColor: Colors.white,
                                      baseColor: Colors.grey.withOpacity(0.5),
                                      child: ShimmerLayout(),
                                      period: Duration(milliseconds: time),
                                    ));
                              });
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
          ],
        ),
      ),
    );
  }
}
