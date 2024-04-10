import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBL1D6fmqKt5D711FmYiLqWQNuv7RYHNmA',
      projectId: 'go-delivery-ebab0',
      appId: '1:121890272297:android:4ef4ae4e7a565b7bc2d838',
      messagingSenderId: '121890272297',
      // Add other necessary options here
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: Splash(),
    );
  }
}
