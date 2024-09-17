import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sinag/Screens/Recommendation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  double? voltage;
  double? current;
  double? energy;
  double? temperature;
  double? total_solar_energy;
  String _location = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _fetchData();
    _getCurrentLocation();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _mockFetchDataFromDatabase();
      print('Fetched data: $data');
      setState(() {
        voltage = data['voltage'];
        current = data['current'];
        energy = data['energy'];
        temperature = data['temperature'];
        total_solar_energy = data['total_solar_energy']; 
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Simulate database 
  Future<Map<String, dynamic>> _mockFetchDataFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return {
      'voltage': 100.2,
      'current': 3.5,
      'energy': 70.0,
      'temperature': 22.0,
      'total_solar_energy': 428.087,
    };
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _location = '${position.latitude.toStringAsFixed(4)}° N, ${position.longitude.toStringAsFixed(4)}° E';
      });
    } catch (e) {
      setState(() {
        _location = 'Error fetching location';
      });
      print('Error fetching location: $e');
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()), // Navigate back to home page
          );
          break;

        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecommendationPage()), // Navigate to recommendation system
          );
          break;

        case 2:
          break;
      }
    }
  }

  void _onButtonPressed() {
    print('Home button pressed!');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );    
  }

  void _onNotificationButtonPressed() {
    print('Notification button pressed!');
  }

  void _onMenuButtonPressed() {
    print('Hamburger menu button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4DE),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Current Location:',
              style: TextStyle(
                color: Color.fromARGB(255, 124, 123, 123),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _location,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: _onMenuButtonPressed,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFC107),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
        ),
        actions: [
          // Add a yellow circle button with a notification icon
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: _onNotificationButtonPressed,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFC107),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFF4DE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Column(
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
                      '${total_solar_energy?.toStringAsFixed(4) ?? '0.0000'}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
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
                  backgroundColor: Color(0xFFFFC107),
                  child: Icon(Icons.wb_sunny, size: 30, color: Colors.white),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFFFC107),
                      child: Icon(Icons.home, size: 30, color: Colors.white),
                    ),
                    SizedBox(width: 100),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFFFC107),
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
                  _buildStatusContainer('VOLTAGE', voltage, 'V', 240.0),
                  const SizedBox(width: 15),
                  _buildStatusContainer('CURRENT', current, 'A', 100.0),
                  const SizedBox(width: 15),
                  _buildStatusContainer('ENERGY', energy, 'kWh', 1000.0),
                  const SizedBox(width: 15),
                  _buildStatusContainer('TEMPERATURE', temperature, '°C', 100.0),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              width: 365,
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
            const SizedBox(height: 20), // Add some spacing between the boxes
            Container(
              height: 250, // Placeholder height, adjust as needed
              width: 365, // Placeholder width, adjust as needed
              decoration: BoxDecoration(
                color: const Color(0xFFB3B3B3),
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
                  'Graph / Charts Area',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFFFC107),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onButtonPressed,
        backgroundColor: Color(0xFFFFC107),
        child: Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildStatusContainer(String label, double? value, String unit, double maxValue) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFB3B3B3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${value?.toStringAsFixed(1) ?? '0.0'} $unit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
