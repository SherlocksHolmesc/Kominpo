import 'package:flutter/material.dart';
import 'package:doctour/Emergency_Call.dart'; // Adjust the import path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthcare Near Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
        ),
      ),
      home: HealthcareScreen(),
    );
  }
}

class HealthcareScreen extends StatefulWidget {
  @override
  _HealthcareScreenState createState() => _HealthcareScreenState();
}

class _HealthcareScreenState extends State<HealthcareScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          // Handle 'Explore' tab
          break;
        case 1:
          // Handle 'Booking' tab
          break;
        case 2:
          // Navigate to EmergencyCallPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmergencyCallScreen()),
          );
          break;
        case 3:
          // Handle 'Consult' tab
          break;
        case 4:
          // Handle 'Profile' tab
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Healthcare Near Me',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFE0F7FA), // Lightest blue for AppBar
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFB3E5FC)
            ], // Super light blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Location',
                  prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Container(
              height: 200,
              child: Image.asset(
                'assets/maps.png', // replace with your own image path
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildHealthcareCard(
                    'IMU Healthcare',
                    '4.0',
                    '34',
                    '126, Jalan Jalil Perkasa 19',
                    'Open Closes 5:30 pm',
                    '03-2731 7661',
                  ),
                  _buildHealthcareCard(
                    'Columbia Asia Hospital',
                    '4.7',
                    '310',
                    '9, Jalan Jalil Perkasa 7',
                    'Open 24 hours',
                    '03-8657 9888',
                  ),
                  _buildHealthcareCard(
                    'Klinik Mediviron Bukit Jalil',
                    '3.4',
                    '40',
                    '22, Jalan Jalil Jaya 6',
                    'Open Closes 8 pm',
                    '03-9544 4645',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthcareCard(
    String name,
    String rating,
    String reviews,
    String address,
    String hours,
    String phone,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16.0),
                SizedBox(width: 4.0),
                Text('$rating ($reviews reviews)',
                    style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
            SizedBox(height: 4.0),
            Text(address, style: TextStyle(color: Colors.blueGrey)),
            SizedBox(height: 4.0),
            Text(hours, style: TextStyle(color: Colors.blueGrey)),
            SizedBox(height: 4.0),
            Text(phone, style: TextStyle(color: Colors.blueGrey)),
          ],
        ),
      ),
    );
  }
}
