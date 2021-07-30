import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens/signup_page.dart';
import 'package:ecommerce/service/alertDialogService.dart';
import 'package:ecommerce/validations/validations.dart';
import 'package:ecommerce/widgets/dumb_widgts/custom_button.dart';
import 'package:ecommerce/widgets/dumb_widgts/cutome_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'landing_page.dart';

class LoginPage extends StatefulWidget {
  static const routName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AlertDialogService _alertSrv = AlertDialogService();
  var _emailAddress = "";
  var _password = "";
  bool _isLoading = false;
  FocusNode _passWordFocusNode = FocusNode();

  Future<String?> _siginWithEmailAndPassword(String email, String pass) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return null;
    } on FirebaseAuthException catch (errorMessage) {
      return FirbaseExceptionsClass()
          .getErrorMessageFromFirebaseException(errorMessage);
    } catch (error) {
      return error.toString();
    }
  }

  Future _submitForm(String email, String pass) async {
    if (Validations().validateEmail(email) != null)
      return _alertSrv.alertDialogBuilder(
          Validations().validateEmail(email).toString(), context);
    final result = await _siginWithEmailAndPassword(email, pass);

    if (result != null)
      return _alertSrv.alertDialogBuilder(result.toString(), context);
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
                  "Welcome User , \nLogin to your Account",
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
                  onChange: (emailVal) {
                    _emailAddress = emailVal;
                  },
                  onSubmit: (_) {
                    _passWordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInputField(
                  hintText: "Password",
                  isItObosecure: true,
                  onChange: (passVal) {
                    _password = passVal;
                  },
                  focusNode: _passWordFocusNode,
                  onSubmit: (_) async {
                    setState(() {
                      _isLoading = true;
                    });
                    await _submitForm(_emailAddress, _password);
                    if (this.mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomButton(
                      isLoading: _isLoading,
                      text: "Login",
                      outLineBtn: false,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await _submitForm(_emailAddress, _password);
                        if (mounted)
                          setState(() {
                            _isLoading = false;
                          });
                      }),
                )
              ])),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: CustomButton(
                  text: "Create New Account",
                  isLoading: false,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SiginupPage.routName);
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
