import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url =
        "https://studyleagueit.com/ditrpEcommerce/app_apis/developerTask.php";
    var response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['result_array'];
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ));
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    String fullName = item['name'];

    int price = item['actual_price'];
    Image imageUrl = item['img_product'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100.0,
              width: 100,
              color: Colors.black12,
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(12.0),
              //   child: Image.network(
              //     imageUrl,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            Container(
              width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: Constants.regularHeading,
                  ),
                  Text(
                    '$price',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            GestureDetector(
              // onTap: () async {
              //   await _addToCart();
              //   Scaffold.of(context).showSnackBar(_snackBar);
              // },
              child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Container(
                  width: 80.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFA8072),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Add",
                            style: Constants.bttnColor,
                          ),
                          Icon(Icons.add, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 8,
          color: Colors.grey,
        ),
      ],
    );
  }
}
