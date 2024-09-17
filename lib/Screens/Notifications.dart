import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4DE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4DE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: Center(
        child: Text(
          'No notification yet.',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
