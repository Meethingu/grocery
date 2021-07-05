import 'package:flutter/material.dart';
import 'package:grocery/services/firebase_services.dart';
import 'package:grocery/widgets/custom_action_bar.dart';
import 'package:grocery/widgets/image_swipe.dart';
import 'package:grocery/widgets/product_size.dart';

import '../constant.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectedProductSize = "0";
  String _selectedProductname = "";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({
      "size": _selectedProductSize,
      "name": _selectedProductname,
    });
  }

  Future _buyOrder() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Orders")
        .doc(widget.productId)
        .set({
      "size": _selectedProductSize,
      "name": _selectedProductname,
    });
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart"),
  );

  final SnackBar _snackBarfinal = SnackBar(
    content: Text("Order is been placed"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Firebase Document Data Map
                Map<String, dynamic> documentData = snapshot.data.data();

                // List of images
                List imageList = documentData['images'];

                var productName = documentData['name'];

                // Set an initial size

                _selectedProductname = productName;

                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['name']}",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "₹${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['desc']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _addToSaved();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                child: Container(
                                  width: 65.0,
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(
                                      "assets/images/tab_saved.png",
                                    ),
                                    height: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await _addToCart();
                                    Scaffold.of(context)
                                        .showSnackBar(_snackBar);
                                  },
                                  child: Container(
                                    height: 65.0,
                                    margin: EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDCDCDC),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Add To Cart",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _buyOrder();
                              Scaffold.of(context).showSnackBar(_snackBarfinal);
                            },
                            child: Container(
                              height: 65.0,
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
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
            hasBackArrrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
