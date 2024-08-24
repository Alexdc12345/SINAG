import 'package:flutter/material.dart';
import 'package:sinag/Screens/Home.dart';
import 'package:sinag/Screens/Tester.dart';
import 'package:sinag/Screens/charttest.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()

    );
  }
}
