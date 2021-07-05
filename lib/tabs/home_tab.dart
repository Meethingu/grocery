import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';
import 'package:grocery/services/firebase_services.dart';
import 'package:grocery/widgets/api.dart';
import 'package:grocery/widgets/custom_action_bar.dart';
import 'package:grocery/widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
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
                return DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      bottom: PreferredSize(
                          child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.white.withOpacity(0.3),
                            indicatorColor: Color(0xFFFA8072),
                            indicatorWeight: 4,
                            tabs: [
                              Text(
                                "Atta and Flours",
                                style: Constants.tabBarbttn,
                              ),
                              Text(
                                "Shampoo",
                                style: Constants.tabBarbttn,
                              ),
                              Text(
                                "All Purpose FLour",
                                style: Constants.tabBarbttn,
                              ),
                            ],
                          ),
                          preferredSize: Size.fromHeight(55.0)),
                    ),
                    body: TabBarView(children: [
                      ListView(
                        padding: EdgeInsets.only(
                          top: 20.0,
                          bottom: 12.0,
                        ),
                        children: snapshot.data.docs.map((document) {
                          return ProductCard(
                            title: document.data()['name'],
                            imageUrl: document.data()['images'][0],
                            price: "\₹ ${document.data()['price']}",
                            productId: document.id,
                          );
                        }).toList(),
                      ),
                      ListView(
                        padding: EdgeInsets.only(
                          top: 20.0,
                          bottom: 12.0,
                        ),
                        children: snapshot.data.docs.map((document) {
                          return ProductCard(
                            title: document.data()['name'],
                            imageUrl: document.data()['images'][0],
                            price: "\₹ ${document.data()['price']}",
                            productId: document.id,
                          );
                        }).toList(),
                      ),
                      ListView(
                        padding: EdgeInsets.only(
                          top: 20.0,
                          bottom: 12.0,
                        ),
                        children: snapshot.data.docs.map((document) {
                          return ProductCard(
                            title: document.data()['name'],
                            imageUrl: document.data()['images'][0],
                            price: "\₹ ${document.data()['price']}",
                            productId: document.id,
                          );
                        }).toList(),
                      ),
                    ]),
                  ),
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
          GestureDetector(
            child: CustomActionBar(
              title: "Groceries",
              hasrightarrow: true,
            ),
          ),
        ],
      ),
    );
  }
}
