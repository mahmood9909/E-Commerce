import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/service/db.dart';
import 'package:ecommerce/service/snack_bar_services.dart';
import 'package:ecommerce/widgets/dumb_widgts/app_bar/cutsom_app_bar.dart';
import 'package:ecommerce/widgets/smart_widgts/sizes_list.dart';
import 'package:ecommerce/widgets/error_widget.dart';
import 'package:ecommerce/widgets/loading_widget.dart';
import 'package:ecommerce/widgets/smart_widgts/imges_slider.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  static const routName = "details-page";

  const DetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  PageController _pageController = PageController();

  DBServices _db = DBServices();

  SnackBarServices _snackBarSrv = SnackBarServices();
  var _selectedSized;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> addToCart(String proID) async {
    final DocumentSnapshot result = await _db.usersCollecation
        .doc(_db.getCureentUserID)
        .collection("cart")
        .doc(proID)
        .get();

    if (result.exists) {
      await _db.usersCollecation
          .doc(_db.getCureentUserID)
          .collection("cart")
          .doc(proID)
          .set({"size": _selectedSized, "qty": result['qty'] + 1});

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("+1 Qunatity")));

      print(result['qty']);
    } else {
      await _db.usersCollecation
          .doc(_db.getCureentUserID)
          .collection("cart")
          .doc(proID)
          .set({"size": _selectedSized, "qty": 1});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("added to the cart")));
    }
  }

  Future<void> _saveTheProduct(String proId) async {
    final DocumentSnapshot result = await _db.usersCollecation
        .doc(_db.getCureentUserID)
        .collection("saved")
        .doc(proId)
        .get();

    if (!result.exists) {
      await _db.usersCollecation
          .doc(_db.getCureentUserID)
          .collection("saved")
          .doc(proId)
          .set({
        "size": _selectedSized,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product is saved")));
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product is already saved ")));
  }

  @override
  Widget build(BuildContext context) {
    final String productID =
        ModalRoute.of(context)!.settings.arguments as String;
    final DocumentReference _singleProductDocumentRef =
        FirebaseFirestore.instance.collection("products").doc(productID);

    Future<void> _swithcToTheSelectedSized(String val) async {
      _selectedSized = val;
      print(_selectedSized);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              hasBackArrow: true,
              hasCartContainer: true,
              title: "Details page",
              hasBackground: false,
            ),
            FutureBuilder(
              future: _singleProductDocumentRef.get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return ErrorExceptions().renderTheError();
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  final images = snapshot.data!.get('images') as List;
                  final sizes = snapshot.data!.get("size") as List;
                  _selectedSized = sizes[0];
                  return Expanded(
                    child: ListView(children: [
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ImagesSlider(
                            images: images,
                            pageCtrl: _pageController,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24.0),
                        child: Text(snapshot.data!.get("name"),
                            style: Constants.heading),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 24.0),
                        child: Text("${snapshot.data!.get("price")} BD",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Text(
                          "${snapshot.data!.get("description").toString().substring(0, 100)} ....",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text(
                          "Size",
                          style: Constants.regularHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListSizes(
                          pro_size: sizes,
                          switchSize: _swithcToTheSelectedSized,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _saveTheProduct(productID);
                              },
                              child: Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                  child: Image(
                                    width: 16.0,
                                    height: 22.0,
                                    image: AssetImage(
                                        "assets/images/tab_saved.png"),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await addToCart(productID);
                                  },
                                  child: Container(
                                      height: 65,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "add to Cart",
                                          style: Constants.buttonsTextWhiteText,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
