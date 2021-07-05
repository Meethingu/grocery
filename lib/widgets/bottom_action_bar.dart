import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/screens/cart_page.dart';
import 'package:grocery/services/firebase_services.dart';

import '../constant.dart';

class BottomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrrow;
  final bool hasTitle;
  final bool hasBackground;
  BottomActionBar(
      {this.title, this.hasBackArrrow, this.hasTitle, this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Color(0xFFFA8072),
      ),
      padding: EdgeInsets.only(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("3 items", style: Constants.tabBarbttn),
          Text("Checkout", style: Constants.tabBarbttn),
        ],
      ),
    );
  }
}
