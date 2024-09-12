import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4DE),
        title: const Text(
          'Logo Placeholder',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFFF4DE), // Background color set to #FFF4DE
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Monthly Total Solar Energy Generated',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '428.0872',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5), // Added SizedBox to provide space between the Text widgets
                  Text(
                    'kWh',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFFFC107), // Changed from orange to #FFC107
                child: Icon(Icons.wb_sunny, size: 30, color: Colors.white),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFFFC107), // Changed from orange to #FFC107
                    child: Icon(Icons.home, size: 30, color: Colors.white),
                  ),
                  SizedBox(width: 100),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFFFC107), // Changed from orange to #FFC107
                    child: Icon(Icons.home, size: 30, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // # VOLTAGE
                _buildStatusContainer('VOLTAGE', '14.934 V', 0.5),
                const SizedBox(width: 15), // Space between rectangles
                // # CURRENT
                _buildStatusContainer('CURRENT', '8.799 A', 0.5),
                const SizedBox(width: 15), // Space between rectangles
                // # ENERGY
                _buildStatusContainer('ENERGY', '24.424 kWh', 0.5),
                const SizedBox(width: 15), // Space between rectangles
                // # TEMPERATURE
                _buildStatusContainer('TEMPERATURE', '33.312 °C', 0.5),
              ],
            ),
          ),
          const SizedBox(height: 20), // Space below the row of containers
          Container(
            height: 40, // Adjusted height to fit the text
            width: 365,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107), // Changed from orange to #FFC107
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Generated Electricity Today',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusContainer(String label, String value, double progress) {
    // Set color based on progress value
    Color progressColor = progress == 0 ? const Color(0xFFD0AD67) : const Color(0xFFF57C00);

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: label == 'TEMPERATURE' ? 9.5 : 12, // Decrease font size for "TEMPERATURE"
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          // Progress bar representation
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress, // Adjust this value to set progress level
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor, // Color of the filled part based on progress
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
