import 'package:flutter/material.dart';
import 'package:sinag/Screens/Home.dart';
import 'package:sinag/Screens/Tester.dart';
import 'package:sinag/Screens/line_chart_test';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LineChartSample()

    );
  }
}
