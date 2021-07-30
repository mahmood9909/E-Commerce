import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firbaseRef = FirebaseFirestore.instance;
  String get getCureentUserID => _auth.currentUser!.uid;

  final CollectionReference usersCollecation =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  CollectionReference userCartCollection() => FirebaseFirestore.instance
      .collection("users")
      .doc(getCureentUserID)
      .collection("cart");
}
