import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/screens/cart_page.dart';
import 'package:grocery/services/firebase_services.dart';
import 'package:grocery/widgets/api.dart';
import 'package:grocery/widgets/apihomepage.dart';

import '../constant.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasrightarrow;
  final bool hasBackArrrow;
  final bool hasTitle;
  final bool hasBackground;

  CustomActionBar(
      {this.title,
      this.hasBackArrrow,
      this.hasTitle,
      this.hasBackground,
      this.hasrightarrow});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    bool _hasrightarrow = hasrightarrow ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFA8072),
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  color: Colors.white,
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Action Bar",
              style: Constants.appBarText,
            ),
          if (_hasrightarrow)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Api()),
                );
              },
              child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.chevron_right_sharp,
                      color: Colors.black12, size: 15)),
            ),
        ],
      ),
    );
  }
}
