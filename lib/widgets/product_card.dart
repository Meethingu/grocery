import 'package:flutter/material.dart';
import 'package:grocery/screens/product_page.dart';
import 'package:grocery/services/firebase_services.dart';

import '../constant.dart';

class ProductCard extends StatefulWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  ProductCard(
      {this.onPressed, this.imageUrl, this.title, this.price, this.productId});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectedProductname = "";

  Future _addToCart() {
    var _selectedProductSize;
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar1 = SnackBar(
    content: Text("Product saved to the cart"),
  );
  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart"),
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productId: widget.productId,
              ),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100.0,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    "${widget.imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Constants.regularHeading,
                    ),
                    Text(
                      widget.price,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await _addToCart();
                  Scaffold.of(context).showSnackBar(_snackBar);
                },
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
      ),
    );
  }
}
