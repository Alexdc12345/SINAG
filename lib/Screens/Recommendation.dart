import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sinag/Screens/Home.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  int _selectedIndex = 0;

  double? voltage;
  double? current;
  double? energy;
  double? temperature;
  String _location = 'Fetching location...';

  String moduleSpecsPlaceholder = 'Fetching specs...';
  String inverterSpecsPlaceholder = 'Fetching specs...';
  String sinagMeterSpecsPlaceholder = 'Fetching specs...';  

  final TextEditingController _house1Controller = TextEditingController(text: 'House 1');
  final TextEditingController _house2Controller = TextEditingController(text: 'House 2');

  final TextEditingController _module = TextEditingController(text: 'Module');
  final TextEditingController _inverter = TextEditingController(text: 'Inverter');
  final TextEditingController _sinagMeter = TextEditingController(text: 'SINAG Meter');

  final TextEditingController _moduleSpecs = TextEditingController();
  final TextEditingController _inverterSpecs = TextEditingController();
  final TextEditingController _sinagMeterSpecs = TextEditingController();

  String _selectedDropdownValue = '3k-5k kWh'; // Default dropdown value
  final List<String> _dropdownItems = ['3k-5k kWh', '5k-7k kWh', '7k-9k kWh', '9k-11k kWh'];
  String _selectedDropdownValue1 = 'NCR'; // Default dropdown value
  final List<String> _dropdownItems1 = ['NCR', 'CAR', 'Region I', 'Region II', 'Region III', 'Region IV-A'];

  @override
  void initState() {
    super.initState();
      // Set initial placeholder text
    _moduleSpecs.text = moduleSpecsPlaceholder;
    _inverterSpecs.text = inverterSpecsPlaceholder;
    _sinagMeterSpecs.text = sinagMeterSpecsPlaceholder;
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

        _moduleSpecs.text = data['moduleSpecsPlaceholder'];
        _inverterSpecs.text = data['inverterSpecsPlaceholder'];
        _sinagMeterSpecs.text = data['sinagMeterSpecsPlaceholder'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<Map<String, dynamic>> _mockFetchDataFromDatabase() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'voltage': 100.2,
      'current': 3.5,
      'energy': 70.0,
      'temperature': 22.0,
      'moduleSpecsPlaceholder': 'SunPower Maxeon 5 AC',
      'inverterSpecsPlaceholder': 'SMA Sunny Boy 5.0',
      'sinagMeterSpecsPlaceholder': 'Eastron SDM630-Modbus',
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
            MaterialPageRoute(builder: (context) => RecommendationPage()), // Navigate back to recommendation system
          );
          break;

        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()), // Navigate to home page
          );
          break;

        case 2:
          // Handle other navigation
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
      backgroundColor: const Color(0xFFFFF4DE),
      body: Column(
        children: [
          AppBar(
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
                    color: const Color(0xFFFFC107),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: _onNotificationButtonPressed,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFC107),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0), // Adjust the value as needed
            child: Container(
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
              child: Center(
                child: Text(
                  'Find the right Solar PV System for your home!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0), // Adjust the value as needed
            child: Container(
              height: 130,
              width: 365,
              decoration: BoxDecoration(
                color: const Color(0xFFFFECB3),
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
              child: Stack(
                children: [
                  // House 1 and House 2 TextFields
                  Positioned(
                    top: 40,
                    left: 10,
                    child: Container(
                      height: 30,
                      width: 100,
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
                      child: Center(
                        child: TextField(
                          controller: _house1Controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 10,
                    child: Container(
                      height: 30,
                      width: 100,
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
                      child: Center(
                        child: TextField(
                          controller: _house2Controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 118, // Position the dropdown next to the "House 1" box
                    child: Container(
                      height: 30,
                      width: 115,
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
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDropdownValue = newValue!;
                              });
                            },
                            items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjusted padding
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 240, // Position the dropdown next to the "House 1" box
                    child: Container(
                      height: 30,
                      width: 115,
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
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDropdownValue1,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDropdownValue1 = newValue!;
                              });
                            },
                            items: _dropdownItems1.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjusted padding
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 118, // Position the dropdown next to the "House 1" box
                    child: Container(
                      height: 30,
                      width: 115,
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
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDropdownValue = newValue!;
                              });
                            },
                            items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjusted padding
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 240, // Position the dropdown next to the "House 1" box
                    child: Container(
                      height: 30,
                      width: 115,
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
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDropdownValue1,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDropdownValue1 = newValue!;
                              });
                            },
                            items: _dropdownItems1.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjusted padding
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),                                                      
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0), // Adjust the value as needed
            child: Container(
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
              child: Center(
                child: Text(
                  'Recommended Solar PV System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0), // Adjust the value as needed
            child: Container(
              height: 130,
              width: 365,
              decoration: BoxDecoration(
                color: const Color(0xFFFFECB3),
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
              child: Stack(
                children: [
                  // House 1 and House 2 TextFields
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 30,
                      width: 100,
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
                      child: Center(
                        child: TextField(
                          controller: _module,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: Container(
                      height: 30,
                      width: 100,
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
                      child: Center(
                        child: TextField(
                          controller: _inverter,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),                  
                  Positioned(
                    top: 90,
                    left: 10,
                    child: Container(
                      height: 30,
                      width: 100,
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
                      child: Center(
                        child: TextField(
                          controller: _sinagMeter,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 130,
                    child: Container(
                      height: 30,
                      width: 225,
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
                      child: Center(
                        child: TextField(
                          controller: _moduleSpecs,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 130,
                    child: Container(
                      height: 30,
                      width: 225,
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
                      child: Center(
                        child: TextField(
                          controller: _inverterSpecs,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 130,
                    child: Container(
                      height: 30,
                      width: 225,
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
                      child: Center(
                        child: TextField(
                          controller: _sinagMeterSpecs,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 13.5), // Adjusted vertical padding
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),                                                                                         
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15.0), // Adjust the value as needed
              child: Container(
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
                child: Center(
                  child: Text(
                    'Return of Investment (ROI)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20), // Add some spacing between the boxes
                  Container(
                    height: 190, // Placeholder height, adjust as needed
                    width: 365, // Placeholder width, adjust as needed
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Placeholder color
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey), // Optional border
                    ),
                    child: const Center(
                      child: Text(
                        'Placeholder Box for Graph',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Add more widgets as needed here
                ],
              ),
            ),                                         
          Expanded(
            child: Center(
              child: Container(
                color: Colors.transparent,
                height: 2,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 61,
            color: const Color(0xFFFFECB3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'Home', 1),
                _buildNavItem(Icons.lightbulb_sharp, 'Recommendation', 0),
                SizedBox(width: 50),
                _buildNavItem(Icons.shopping_cart, 'Marketplace', 2),
                _buildNavItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
          Positioned(
            bottom: 22,
            left: MediaQuery.of(context).size.width / 2 - 37.5,
            child: InkWell(
              onTap: _onButtonPressed,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 75,
                height: 75,
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
                  child: Image.asset('assets/sun_icon.png', width: 45, height: 45),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Color(0xFFFFC107) : Color(0xFF00796B),
            size: 35,
          ),
        ],
      ),
    );
  }
}
