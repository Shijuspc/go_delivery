import 'package:flutter/material.dart';
import 'package:go_delivery/cart.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 94, 94, 1),
        title: Center(
          child: Text(
            'Iphone',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
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
                      "https://m.media-amazon.com/images/I/31VjlrbE3bL._SY445_SX342_QL70_FMwebp_.jpg",
                      width: double.maxFinite,
                      height: 250,
                      fit: BoxFit.fitHeight,
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
                      'Rs: 100000',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset('lib/image/star.png')),
                        Text('3.0'),
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
                      'Iphone',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: Color.fromRGBO(255, 94, 94, 1),
                        ),
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
                  'Apple',
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
              'iPhone 13 boasts an advanced dual-camera system that allows you to click mesmerizing pictures with immaculate clarity. Furthermore, the lightning-fast A15 Bionic chip allows for seamless multitasking, elevating your performance to a new dimension. A big leap in battery life, a durable design, and a bright Super Retina XDR display facilitate boosting your user experience.',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
              },
              child: Container(
                color: Color.fromRGBO(252, 252, 252, 1),
                width: MediaQuery.of(context).size.width / 2,
                height: 50.0,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: Color.fromRGBO(255, 94, 94, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 94, 94, 1),
                    ),
                  )
                ]),
              ),
            ),
            Container(
              color: Color.fromRGBO(255, 94, 94, 1),
              width: MediaQuery.of(context).size.width / 2,
              height: 50.0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.shopping_bag_rounded, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Buy',
                  style: TextStyle(color: Colors.white),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
