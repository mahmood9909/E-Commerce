import 'package:ecommerce/screens/Loading.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/occ2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static const routName = "/";
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> streamSnapshot) {
          // If Stream Snapshot has error
          if (streamSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${streamSnapshot.error}"),
              ),
            );
          }

          // Connection state active - Do the user login check inside the
          // if statement
          if (streamSnapshot.connectionState == ConnectionState.active) {
            // Get the user
            User? _user = streamSnapshot.data;

            // If the user is null, we're not logged in
            if (_user == null) {
              // user not logged in, head to login
              return LoginPage();
            } else {
              // The user is logged in, head to homepage
              return HomePage2();
            }
          }
          return LoadingState();
        });
  }
}
