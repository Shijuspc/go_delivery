import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_delivery/order.dart';

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  String? selectedValue = '1';
  int selectedradio = 0;
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
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.maxFinite,
              height: 120,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                            'Postmaster, Palakkad City S.O, Palakkad, Kerala, India (IN), Pin Code:-678014.',
                            style: TextStyle(fontSize: 14)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.edit),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
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
                          "https://rukminim1.flixcart.com/image/832/832/ktketu80/mobile/8/z/w/iphone-13-mlph3hn-a-apple-original-imag6vzzhrxgazsg.jpeg",
                          height: 120,
                          width: 100,
                          fit: BoxFit.scaleDown,
                        ),
                        Container(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 5),
                              Text(
                                "Iphone",
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
                                    "Rs: 200",
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
                                        child:
                                            Image.asset('lib/image/star.png'),
                                      ),
                                      Text('3.0'),
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
                                        fontSize: 16, color: Colors.black),
                                    value: selectedValue,
                                    items: ['1', '2', '3', '4', '5', '6'].map(
                                      (String item) {
                                        return DropdownMenuItem<String>(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.maxFinite,
              height: 270,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Payment Option',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      RadioListTile(
                        title: Text('UPI'),
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedradio = 1;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Debit Card'),
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedradio = 2;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Credit Card'),
                        value: 3,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedradio = 3;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Cash on Delivery'),
                        value: 3,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedradio = 3;
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
            padding:
                const EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
            child: Card(
              elevation: 2,
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Item Price :',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rs 200',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
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
                            'Discount :',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rs -40',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
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
                            'Shipping Charge :',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rs 40',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount :',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs 400',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ]),
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
                      builder: (context) => Order(),
                    ));
              },
              child: Container(
                color: Color.fromRGBO(255, 94, 94, 1),
                width: MediaQuery.of(context).size.width / 1,
                height: 50.0,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.shopping_bag_rounded, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Order Now',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
