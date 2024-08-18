import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int? _selectedRideIndex;
  bool _isPaymentOpen = false; // Track if the payment box is open
  String _startLocation = ''; // Track start location
  String _endLocation = ''; // Track end location

  void _switchLocations() {
    setState(() {
      final temp = _startLocation;
      _startLocation = _endLocation;
      _endLocation = temp;
    });
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildRidePage();
      case 1:
        return BookingPage();
      case 2:
        return EmergencyPage();
      case 3:
        return ConsultPage();
      case 4:
        return ProfilePage();
      default:
        return Center(child: Text('Page not found'));
    }
  }

  Widget _buildRidePage() {
    return Stack(
      children: [
        Container(
          color: Colors.lightBlue[50], // Light blue background for the page
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Map Section
                Container(
                  width: double.infinity,
                  height: 300, // Increased map height
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/map.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: _buildLocationBox(
                                        'Start Location',
                                        _startLocation,
                                        (value) => setState(
                                            () => _startLocation = value))),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: _switchLocations,
                                  child: Icon(Icons.swap_horiz,
                                      color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.blue[700], // Button color
                                    shape: CircleBorder(), // Circular button
                                    padding:
                                        EdgeInsets.all(12), // Button padding
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: _buildLocationBox(
                                        'End Location',
                                        _endLocation,
                                        (value) => setState(
                                            () => _endLocation = value))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Ride Options Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildRideCard(
                        index: 0,
                        title: 'JustCar',
                        subtitle: 'Nearest Car or Taxi',
                        price: 'RM14.00',
                        icon: Icons.directions_car,
                      ),
                      SizedBox(height: 10),
                      _buildRideCard(
                        index: 1,
                        title: 'Taxi Metered',
                        subtitle: 'Metered Budget Taxi',
                        price: 'RM21.00-31.00',
                        icon: Icons.directions_car_rounded,
                      ),
                      SizedBox(height: 10),
                      _buildRideCard(
                        index: 2,
                        title: '6-seater Car',
                        subtitle: 'Alza, Aruz, & Others',
                        price: 'RM23',
                        icon: Icons.directions_car_rounded,
                      ),
                      SizedBox(height: 20),
                      // Wallet and Book Now Button Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPaymentOpen = !_isPaymentOpen;
                              });
                            },
                            child: Text(
                              'Payment Option',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality for booking
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 255,
                                  255, 255), // Bolder blue for book now button
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 30,
                              ),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // White text color
                              ),
                            ),
                            child: Text('Book Now'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Slide-Up Payment Options
        if (_isPaymentOpen)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Choose Payment Method',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Visa'),
                    onTap: () {
                      // Handle Visa payment selection
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.money),
                    title: Text('Cash'),
                    onTap: () {
                      // Handle Cash payment selection
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isPaymentOpen = false; // Close the payment options
                      });
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLocationBox(
      String hintText, String value, ValueChanged<String> onChanged) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
        onChanged: onChanged,
        controller: TextEditingController(text: value),
      ),
    );
  }

  Widget _buildRideCard({
    required int index,
    required String title,
    required String subtitle,
    required String price,
    required IconData icon,
  }) {
    final isSelected = _selectedRideIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRideIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue[100]
              : Colors.white, // Change color when selected
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.blue[700]),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Set the toolbar height for the app bar if needed
        toolbarHeight: 60,
        title: Center(
          child: Text(
            'Rides',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor:
            Colors.blue, // Set the app bar background color if needed
      ),
      body: _buildPageContent(),
    );
  }
}

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Booking Page'));
  }
}

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Emergency Page'));
  }
}

class ConsultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Consult Page'));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Page'));
  }
}
