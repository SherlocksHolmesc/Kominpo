import 'package:flutter/material.dart';
import 'package:doctour/flight.dart';
import 'package:doctour/hotel.dart';
import 'package:doctour/ride.dart';
import 'package:doctour/home.dart'; // Import other screens
import 'package:doctour/emergency_call.dart';
import 'package:doctour/Consult.dart';
import 'package:doctour/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingPageMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BookingPageMain extends StatefulWidget {
  @override
  _BookingPageMainState createState() => _BookingPageMainState();
}

class _BookingPageMainState extends State<BookingPageMain> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    HomePage(),
    BookingPageMain(), // This should ideally not include itself
    EmergencyCallScreen(),
    DoctorListPage(),
    ProfilePageMain(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BookingCard(
              imagePath: 'assets/travelling.png',
              title: 'Flights',
              description:
                  'Book your flights here. Get the best deals on international.',
              color: Colors.blue.shade50,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlightBookingApp()),
                );
              },
            ),
            BookingCard(
              imagePath: 'assets/hotel.png',
              title: 'Hotels',
              description:
                  'Find the best hotels around the world. Book your stay now.',
              color: Colors.blue.shade50,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HotelBookingPage()),
                );
              },
            ),
            BookingCard(
              imagePath: 'assets/transport.png',
              title: 'Rides',
              description:
                  'Book a ride. Get to your destination safely and on time.',
              color: Colors.blue.shade50,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade50,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/application.png',
              width: 35,
              height: 35,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/booking.png',
              width: 35,
              height: 35,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/emergency-call.png',
              width: 35,
              height: 35,
            ),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/chat.png',
              width: 35,
              height: 35,
            ),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/user.png',
              width: 35,
              height: 35,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        iconSize: 24,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  BookingCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, width: 90, height: 90),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
