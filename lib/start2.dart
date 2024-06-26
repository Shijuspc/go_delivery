import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_delivery/login.dart';

class Start2 extends StatefulWidget {
  const Start2({super.key});

  @override
  State<Start2> createState() => _Start2State();
}

class _Start2State extends State<Start2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(

            height: 50,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text('Skip',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
              height: 400,
              child: Image.asset('lib/image/start2.jpg'),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Whether its an urgent document, a',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 49, 31, 31)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'valuable item, or a gift for a loved',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(40, 35, 35, 1)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'one, our app ensures a seamless and',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(40, 35, 35, 1)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'reliable courier experience',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(40, 35, 35, 1)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 60,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size.fromHeight(50),
                                        elevation: 0,
                                        backgroundColor:
                                            Color.fromRGBO(255, 94, 94, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Login(),
                                          ));
                                    },
                                    child: Center(
                                        child: Icon(Icons.arrow_forward,color: Colors.white,))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
