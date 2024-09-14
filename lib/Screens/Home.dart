import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _mockFetchDataFromDatabase();
      print('Fetched data: $data'); // Debug print
      setState(() {
        voltage = data['voltage'];
        current = data['current'];
        energy = data['energy'];
        temperature = data['temperature'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Database simulation
  Future<Map<String, dynamic>> _mockFetchDataFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return {
      // Example values for testing
      'voltage': 47.2, 
      'current': 3.5,
      'energy': 40.0,
      'temperature': 22.0,
    };
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

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
      backgroundColor: const Color(0xFFFFF4DE),
      body: SingleChildScrollView(
        child: Column(
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
                  // Display voltage with a maximum value of 240 volts
                  _buildStatusContainer('VOLTAGE', voltage, 'V', 240.0),
                  const SizedBox(width: 15),
                  // Display current with a maximum value of 100 amps
                  _buildStatusContainer('CURRENT', current, 'A', 100.0),
                  const SizedBox(width: 15),
                  // Display energy with a maximum value of 1000 kWh
                  _buildStatusContainer('ENERGY', energy, 'kWh', 1000.0),
                  const SizedBox(width: 15),
                  // Display temperature with a maximum value of 100°C
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFECB3),
        unselectedItemColor: const Color(0xFF00796B),
        selectedItemColor: const Color(0xFF00796B),
        selectedLabelStyle: const TextStyle(
          color: Color(0xFF00796B),
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xFF00796B),
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.home, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.history, 1),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.monetization_on, 2),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.person, 3),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusContainer(String label, double? value, String unit, double maxValue) {
    String displayValue = value != null ? value.toStringAsFixed(2) : '0.00';
    
    double progressValue = (value ?? 0.0) / maxValue;
    
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
              fontSize: label == 'TEMPERATURE' ? 9.5 : 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$displayValue $unit',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                Container(
                  width: 60 * progressValue,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    return Icon(
      icon,
      color: isSelected ? const Color(0xFFFFC107) : const Color(0xFF00796B),
      size: isSelected ? 30 : 24,
    );
  }
}
