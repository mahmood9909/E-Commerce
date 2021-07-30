// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/cart_page.dart';
import 'package:ecommerce/screens/details_page.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          accentColor: Color(0xFFFF1E00),
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      initialRoute: "/",
      routes: {
        LandingPage.routName: (context) => LandingPage(),
        LoginPage.routName: (context) => LoginPage(),
        SiginupPage.routName: (context) => SiginupPage(),
        DetailsPage.routName: (context) => DetailsPage(),
        CartPage.routName: (context) => CartPage()
      },
    );
  }
}
