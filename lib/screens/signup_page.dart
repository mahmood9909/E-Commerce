import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens/landing_page.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/service/alertDialogService.dart';
import 'package:ecommerce/validations/validations.dart';
import 'package:ecommerce/widgets/dumb_widgts/custom_button.dart';
import 'package:ecommerce/widgets/dumb_widgts/cutome_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SiginupPage extends StatefulWidget {
  static const routName = "/sgin-up";
  const SiginupPage({Key? key}) : super(key: key);

  @override
  _SiginupPageState createState() => _SiginupPageState();
}

class _SiginupPageState extends State<SiginupPage> {
  bool _isLoading = false;
  var _emailAddreess = "";
  var _password = "";
  FocusNode _passWordFocusNode = FocusNode();
  AlertDialogService _alertSrv = AlertDialogService();

  Future<String?> _siginUpWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(result.user!.uid)
      //     .set({"userRole": "Customer"});
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: '+973 38267224',
      //   verificationCompleted: (PhoneAuthCredential credential) {},
      //   verificationFailed: (FirebaseAuthException e) {},
      //   codeSent: (String verificationId, int? resendToken) {},
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      // );
      return null;
    } on FirebaseAuthException catch (error) {
      return FirbaseExceptionsClass()
          .getErrorMessageFromFirebaseException(error);
    } catch (errorMessage) {
      return errorMessage.toString();
    }
  }

  Future _submitForm(String email, String pass) async {
    if (Validations().validateEmail(email) != null)
      return _alertSrv.alertDialogBuilder(
          Validations().validateEmail(email).toString(), context);

    final result = await _siginUpWithEmailAndPassword(email, pass);

    if (result != null)
      return _alertSrv.alertDialogBuilder(result.toString(), context);

    if (result == null)
      Navigator.of(context).pushReplacementNamed(LandingPage.routName);
  }

  @override
  void dispose() {
    _passWordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.heading,
                ),
              ),
              Spacer(),
              Container(
                  child: Column(children: [
                CustomInputField(
                  hintText: "Email",
                  isItObosecure: false,
                  onChange: (emailValue) {
                    _emailAddreess = emailValue;
                  },
                  onSubmit: (_) {
                    _passWordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInputField(
                  hintText: "Password",
                  isItObosecure: true,
                  onChange: (pass) {
                    _password = pass;
                  },
                  focusNode: _passWordFocusNode,
                  onSubmit: (_) async {
                    setState(() {
                      _isLoading = true;
                    });

                    await _submitForm(_emailAddreess, _password);

                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomButton(
                    text: "Sign up",
                    outLineBtn: false,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      await _submitForm(_emailAddreess, _password);

                      setState(() {
                        _isLoading = false;
                      });
                    },
                    isLoading: _isLoading,
                  ),
                )
              ])),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: CustomButton(
                  text: "Back To Login",
                  isLoading: false,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginPage.routName);
                  },
                  outLineBtn: true,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
