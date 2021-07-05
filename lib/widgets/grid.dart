import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: <Widget>[
          Container(
            color: Colors.black12,
            child: Center(
              child: Text(
                "Indevelopment",
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Center(
              child: Text(
                "Indevelopment",
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Center(
              child: Text(
                "Indevelopment",
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Center(
              child: Text(
                "Indevelopment",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
