import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_delivery/order.dart';
import 'package:go_delivery/profile.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  String? selectedValue = '1';
  String selectedPayment = '';
  String address = '';
  String image = '';
  String name = '';
  int price = 0;
  String rate = '';
  int qty = 1;

  @override
  void initState() {
    super.initState();
    fetchAddress();
    fetchCartItems();
  }

  void fetchAddress() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> userData =
              documentSnapshot.data() as Map<String, dynamic>;
          setState(() {
            address = userData['address'];
          });
        }
      });
    }
  }

  void fetchCartItems() {
    FirebaseFirestore.instance
        .collection('cart')
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = snapshot.docs.first;
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          name = data['name'] as String;
          image = data['image'] as String;
          price = data['price'] as int;
          rate = data['rate'] as String;
          qty = data['qty'] as int;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 94, 94, 1),
        title: Center(
          child: Text(
            'Confirm Order',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Product').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 120,
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                              ),
                              child: Text(
                                address,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(),
                                    ),
                                  );
                                },
                                child: Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('cart').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    elevation: 2,
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
                                          color: Color.fromRGBO(255, 94, 94, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Price: \₹${price}',
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
                                          DropdownButton<int>(
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            value: qty,
                                            items: [1, 2, 3, 4, 5, 6]
                                                .map((int item) {
                                              return DropdownMenuItem<int>(
                                                child: Text(item.toString()),
                                                value: item,
                                              );
                                            }).toList(),
                                            onChanged: (int? value) {
                                              setState(() {
                                                qty = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.maxFinite,
                height: 270,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Payment Option',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RadioListTile(
                          title: Text('UPI'),
                          value: 'UPI',
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            setState(() {
                              selectedPayment = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('Debit Card'),
                          value: 'Debit Card',
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            setState(() {
                              selectedPayment = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('Credit Card'),
                          value: 'Credit Card',
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            setState(() {
                              selectedPayment = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('Cash on Delivery'),
                          value: 'Cash on Delivery',
                          groupValue: selectedPayment,
                          onChanged: (value) {
                            setState(() {
                              selectedPayment = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(255, 94, 94, 1),
                    ),
                  ),
                  onPressed: () {
                    addOrderCollection();
                    deleteCartCollection();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => order(),
                        ));
                  },
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addOrderCollection() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      FirebaseFirestore.instance.collection('orders').add({
        'userId': user.uid,
        'address': address,
        'image': image,
        'name': name,
        'price': price,
        'payment': selectedPayment,
        'date': Timestamp.now(),
      }).then((value) {
        print('Order placed successfully!');
      }).catchError((error) {
        print('Failed to place order: $error');
      });
    }
  }

  void deleteCartCollection() {
    FirebaseFirestore.instance.collection('cart').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
      print('Cart collection deleted successfully!');
    }).catchError((error) {
      print('Failed to delete cart collection: $error');
    });
  }
}
