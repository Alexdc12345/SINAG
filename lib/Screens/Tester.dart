import 'package:flutter/material.dart';


class Tester extends StatelessWidget {
  const Tester({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF4DE), // Background color
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Lines and Arrows
              Positioned(
                top: 100,
                left: 70,
                right: 70,
                child: CustomPaint(
                  size: Size(300, 100),
                  painter: LinePainter(),
                ),
              ),
              // Center Circle with Icon
              const Positioned(
                top: 50,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.wb_sunny, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              // Left Circle with Icon and Text
              const Positioned(
                left: 20,
                bottom: 50,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.home, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '214.0436\nkWh',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Right Circle with Icon and Text
              const Positioned(
                right: 20,
                bottom: 50,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.home, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '214.0436\nkWh',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter to draw lines and arrows
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Draw horizontal line
    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);
    canvas.drawLine(startPoint, endPoint, paint);

    // Draw vertical line
    final midPoint = Offset(size.width / 2, 0);
    final midEndPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawLine(midPoint, midEndPoint, paint);

    // Draw left arrow
    for (double i = 50; i < size.width / 2; i += 40) {
      canvas.drawLine(Offset(i, size.height / 2 - 5), Offset(i - 10, size.height / 2), paint);
      canvas.drawLine(Offset(i, size.height / 2 + 5), Offset(i - 10, size.height / 2), paint);
    }

    // Draw right arrow
    for (double i = size.width - 50; i > size.width / 2; i -= 40) {
      canvas.drawLine(Offset(i, size.height / 2 - 5), Offset(i + 10, size.height / 2), paint);
      canvas.drawLine(Offset(i, size.height / 2 + 5), Offset(i + 10, size.height / 2), paint);
    }

    // Draw top arrow
    for (double i = 20; i < size.height / 2; i += 40) {
      canvas.drawLine(Offset(size.width / 2 - 5, i), Offset(size.width / 2, i - 10), paint);
      canvas.drawLine(Offset(size.width / 2 + 5, i), Offset(size.width / 2, i - 10), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
