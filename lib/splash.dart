import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:go_delivery/home.dart';
import 'package:go_delivery/start.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => checkUserAuthentication(),
    );
  }

  Future<void> checkUserAuthentication() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Start()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset('lib/image/splash.png'))),
          SizedBox(
            width: 15,
          ),
          Text(
            'Go Delivery',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 94, 94, 1),
            ),
          )
        ]),
      )),
    );
  }
}
