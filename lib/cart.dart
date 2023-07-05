import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_delivery/buy.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String? selectedValue = '1';
  // double itemsPrice = 0;
  // double discount = 40.0;
  // double shippingCharge = 40.0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 94, 94, 1),
        title: Center(
          child: Text(
            'Cart',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where('userId', isEqualTo: userId) // Filter by userId
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final cartItems = snapshot.data!.docs;

                  // // Calculate itemsPrice
                  // itemsPrice = cartItems.fold(0, (total, item) {
                  //   final cartData = item.data() as Map<String, dynamic>;
                  //   final price = cartData['price'] as num;
                  //   return total + price.toDouble();
                  // });

                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartData =
                          cartItems[index].data() as Map<String, dynamic>;

                      final image = cartData['image'] as String;
                      final name = cartData['name'] as String;
                      final price = cartData['price'] as num;
                      final rate = cartData['rate'] as String;

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(
                              color: Colors.black26,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      image,
                                      height: 120,
                                      width: 100,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Container(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(height: 5),
                                          Text(
                                            name,
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 94, 94, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                price.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(width: 30),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child: Image.asset(
                                                        'lib/image/star.png'),
                                                  ),
                                                  Text(rate),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Qty",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(width: 10),
                                              DropdownButton<String>(
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                value: selectedValue,
                                                items: [
                                                  '1',
                                                  '2',
                                                  '3',
                                                  '4',
                                                  '5',
                                                  '6'
                                                ].map(
                                                  (String item) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      child: Text(item),
                                                      value: item,
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedValue = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color.fromRGBO(
                                                    255, 94, 94, 1),
                                              ),
                                              onPressed: () {
                                                deleteCartItem(
                                                    cartItems[index].id);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Placeholder();
              },
            ),
          ),
          // BottomAppBar(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: Container(
          //       color: Color.fromRGBO(255, 255, 255, 1),
          //       width: MediaQuery.of(context).size.width / 1,
          //       height: 120.0,
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 30, right: 30),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             SizedBox(width: 10),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Items Price :',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Text(
          //                   itemsPrice.toString(),
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             SizedBox(height: 10),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Discount :',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Text(
          //                   'Rs -40',
          //                   style: TextStyle(
          //                     color: Colors.green,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             SizedBox(height: 10),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Shipping Charge :',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Text(
          //                   'Rs 40',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             SizedBox(height: 15),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'Total Amount :',
          //                   style: TextStyle(
          //                     fontSize: 17,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   calculateTotal().toString(),
          //                   style: TextStyle(
          //                     fontSize: 17,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
                    builder: (context) => Buy(),
                  ),
                );
              },
              child: Container(
                color: Color.fromRGBO(255, 94, 94, 1),
                width: MediaQuery.of(context).size.width / 1,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // double calculateTotal() {
  //   return itemsPrice - discount + shippingCharge;
  // }

  void deleteCartItem(String cartItemId) {
    FirebaseFirestore.instance.collection('cart').doc(cartItemId).delete();
    setState(() {});
  }
}
