import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
