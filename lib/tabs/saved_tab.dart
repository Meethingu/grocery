import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';
import 'package:grocery/screens/product_page.dart';
import 'package:grocery/services/firebase_services.dart';
import 'package:grocery/widgets/bottom_action_bar.dart';
import 'package:grocery/widgets/custom_action_bar.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  int _itemCount = 0;
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return Column(
                  children: [
                    Container(
                      height: 780,
                      child: ListView(
                        padding: EdgeInsets.only(
                          top: 108.0,
                          bottom: 12.0,
                        ),
                        children: snapshot.data.docs.map((document) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                      productId: document.id,
                                    ),
                                  ));
                            },
                            child: FutureBuilder(
                              future: _firebaseServices.productsRef
                                  .doc(document.id)
                                  .get(),
                              builder: (context, productSnap) {
                                if (productSnap.hasError) {
                                  return Container(
                                    child: Center(
                                      child: Text("${productSnap.error}"),
                                    ),
                                  );
                                }

                                if (productSnap.connectionState ==
                                    ConnectionState.done) {
                                  Map _productMap = productSnap.data.data();

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                          horizontal: 10.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  "${_productMap['images'][0]}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Container(
                                                width: 150,
                                                padding: EdgeInsets.only(
                                                  left: 16.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${_productMap['name']}",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 4.0,
                                                      ),
                                                      child: Text(
                                                        "\$${_productMap['price']}",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  child: Icon(Icons.delete,
                                                      color: Color(0xFFFA8072)),
                                                  onTap: () {
                                                    {
                                                      return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              32.0))),
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      top:
                                                                          10.0),
                                                              content:
                                                                  Container(
                                                                height: 200,
                                                                width: 500,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          "Delete Product",
                                                                          style:
                                                                              Constants.boldHeading,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                      height:
                                                                          4.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              20,
                                                                          horizontal:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        "Are you sure you want to delete the product?",
                                                                        style: Constants
                                                                            .regularHeading,
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        RaisedButton(
                                                                          color:
                                                                              Color(0xFFFA8072),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Cancel",
                                                                            style:
                                                                                Constants.bttnColor,
                                                                          ),
                                                                        ),
                                                                        RaisedButton(
                                                                          color:
                                                                              Color(0xFFFA8072),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Yes",
                                                                            style:
                                                                                Constants.bttnColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    }
                                                  },
                                                ),
                                                SizedBox(height: 40),
                                                Row(
                                                  children: <Widget>[
                                                    _itemCount != 0
                                                        ? new IconButton(
                                                            alignment: Alignment
                                                                .center,
                                                            icon: new Icon(
                                                                Icons.remove),
                                                            onPressed: () =>
                                                                setState(() =>
                                                                    _itemCount--),
                                                          )
                                                        : new Container(),
                                                    Container(
                                                      height: 25,
                                                      width: 35,
                                                      color: Color(0xFFFA8072),
                                                      child: new Text(
                                                        _itemCount.toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            Constants.bttnColor,
                                                      ),
                                                    ),
                                                    new IconButton(
                                                        icon:
                                                            new Icon(Icons.add),
                                                        onPressed: () =>
                                                            setState(() =>
                                                                _itemCount++))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.grey),
                                    ],
                                  );
                                }

                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 50,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: Color(0xFFFA8072),
                            border: Border.all(
                              color: Color(0xFFFA8072),
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("3 items", style: Constants.appBarText),
                              Container(
                                child: Row(
                                  children: [
                                    Text("Checkout",
                                        style: Constants.appBarText),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Cart",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
