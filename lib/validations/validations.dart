import 'package:firebase_auth/firebase_auth.dart';

// client side validations side validations
class Validations {
  String? validateEmail(String email) {
    final String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool regPattern = RegExp(pattern).hasMatch(email);

    if (!regPattern)
      return "Plesae insert a valid email and passwrod";
    else
      return null;
  }
}

// server side validations
class FirbaseExceptionsClass {
  String getErrorMessageFromFirebaseException(FirebaseAuthException exception) {
    String exceptionMessage;

    switch (exception.code.toLowerCase()) {
      case 'email-already-in-use':
        exceptionMessage =
            'An account already exists for the email you\'re trying to use. Login instead.';
        break;
      case 'email-already-exists':
        exceptionMessage =
            'The email has already been registered. Please login or reset your password.';
        break;
      case 'invalid-email':
        exceptionMessage =
            'The email you\'re using is invalid. Please use a valid email.';
        break;
      case 'operation-not-allowed':
        exceptionMessage =
            'The authentication is not enabled on Firebase. Please enable the Authentitcation type on Firebase';
        break;
      case 'weak-password':
        exceptionMessage =
            'Your password is too weak. Please use a stronger password.';
        break;
      case 'wrong-password':
        exceptionMessage =
            'You seemed to have entered the wrong password. Double check it and try again.';
        break;
      case 'requires-recent-login':
        exceptionMessage =
            'The user must reauthenticate before this operation can be executed.';
        break;
      case 'user-not-found':
        exceptionMessage = 'User with this email doesn\'t exist.';
        break;
      case 'user-disabled':
        exceptionMessage = 'User with this email has been disabled.';
        break;
      case 'too-many-requests':
        exceptionMessage = 'Too many requests. Try again later.';
        break;
      case 'operation-not-allowed':
        exceptionMessage = 'Signing in with Email and Password is not enabled.';
        break;
      default:
        return exception.message ??
            'Something went wrong on our side. Please try again';
    }
    return exceptionMessage;
  }
}
