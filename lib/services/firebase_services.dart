import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference attasRef =
      FirebaseFirestore.instance.collection("Attas");

  final CollectionReference purposeFlourRef =
      FirebaseFirestore.instance.collection("Purpose FLour");

  final CollectionReference shampooRef =
      FirebaseFirestore.instance.collection("Shampoo");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");
}
