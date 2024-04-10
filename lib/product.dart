import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_delivery/cart.dart';

class Product extends StatefulWidget {
  const Product({
    Key? key,
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late String image;
  late String name;
  late String brand;
  late String rate;
  late String price;
  late String des;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String image = arguments['image'].toString();
    final String name = arguments['name'].toString();
    final String brand = arguments['brand'].toString();
    final String rate = arguments['rate'].toString();
    final String price = arguments['price'].toString();
    final String des = arguments['des'].toString();

    void addToCart() {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      final cartRef = FirebaseFirestore.instance.collection('cart').doc();

      final cartData = {
        'userId': userId, // Add the user ID to the cart data
        'image': image,
        'name': name,
        'brand': brand,
        'rate': rate,
        'price': int.parse(price),
        'des': des,
        'time': DateTime.now(),
      };

      cartRef
          .set(cartData)
          .then((value) => print('Item added to cart'))
          .catchError((error) => print('Failed to add item to cart: $error'));
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 94, 94, 1),
        title: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        image,
                        width: double.maxFinite,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${price}",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset('lib/image/star.png')),
                          Text(rate),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          // Icon(
                          //   Icons.favorite_border_rounded,
                          //   color: Color.fromRGBO(255, 94, 94, 1),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            child: Icon(
                              Icons.share,
                              color: Color.fromRGBO(255, 94, 94, 1),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    brand,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 116, 115, 115),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Divider(
              color: Color.fromARGB(255, 253, 253, 253),
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 80, 80, 80),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 30, top: 10),
              child: Text(
                des,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                addToCart();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
              },
              child: Container(
                color: Color.fromRGBO(255, 94, 94, 1),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50.0,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: Color.fromRGBO(252, 252, 252, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(252, 252, 252, 1),
                    ),
                  )
                ]),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => Buy(),
            //         ));
            //   },
            //   child: Container(
            //     color: Color.fromRGBO(255, 94, 94, 1),
            //     width: MediaQuery.of(context).size.width / 2,
            //     height: 50.0,
            //     child:
            //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //       Icon(Icons.shopping_bag_rounded, color: Colors.white),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         'Buy',
            //         style: TextStyle(color: Colors.white),
            //       )
            //     ]),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
