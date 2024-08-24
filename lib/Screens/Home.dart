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
                'Monthly Total solar Energy Generated',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
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
                        color: Colors.black
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'kWh',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
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
                backgroundColor: Colors.orange,
                child: Icon(Icons.wb_sunny, size: 30, color: Colors.white),
              ),
              SizedBox(height: 4),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.home, size: 30, color: Colors.white),
                    ),
                    SizedBox(width: 100),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.home, size: 30, color: Colors.white),
                  ),
                ]
              )
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
            height: 20,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.orange,
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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Generated Electricity Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          LineChart(
            LineChartData(
              gridData: const FlGridData(show: true), // Removed const from here
              titlesData: const FlTitlesData(show: true),
              borderData: FlBorderData(show: true),

            )

          ),
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
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.orange,
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
            style: const TextStyle(
              fontSize: 12,
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
                  color: Colors.orange[900], // Color of the filled part
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
