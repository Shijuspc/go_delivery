import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_delivery/cart.dart';
import 'package:go_delivery/login.dart';
import 'package:go_delivery/order.dart';
import 'package:go_delivery/product.dart';
import 'package:go_delivery/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    } catch (e) {
      print('Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 94, 94, 1),
        title: Center(
          child: Text(
            'Shopping',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ));
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 94, 94, 1),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  }
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final email = userData['email'];
                  final name = userData['name'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://i.pinimg.com/474x/4c/3e/3b/4c3e3b91f05a5765aa544ac7557d6642.jpg',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Color.fromRGBO(255, 94, 94, 1),
              ),
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Profile();
                  },
                ));
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.favorite,
            //     color: Color.fromRGBO(255, 94, 94, 1),
            //   ),
            //   title: Text('Favorites'),
            //   onTap: () {},
            // ),
            ListTile(
              leading: Icon(
                Icons.shopping_basket,
                color: Color.fromRGBO(255, 94, 94, 1),
              ),
              title: Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => order(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart_rounded,
                color: Color.fromRGBO(255, 94, 94, 1),
              ),
              title: Text('Cart'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color.fromRGBO(255, 94, 94, 1),
              ),
              title: Text('Logout'),
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Product').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            final products = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(5),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.80,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final String image = product['image'];
                      final String name = product['name'];
                      final String brand = product['brand'];
                      final String rate = product['rate'];
                      final String price = product['price'];
                      final String des = product['des'];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Product(),
                              settings: RouteSettings(
                                arguments: {
                                  'image': image,
                                  'name': name,
                                  'brand': brand,
                                  'rate': rate,
                                  'price': price,
                                  'des': des,
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color.fromRGBO(255, 94, 94, 1),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3.0,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      image,
                                      width: 155,
                                      height: 155,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 94, 94, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            child: Image.asset(
                                          'lib/image/star.png',
                                          height: 25,
                                          width: 25,
                                        )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          rate,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      brand,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 116, 115, 115),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '₹${price}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
