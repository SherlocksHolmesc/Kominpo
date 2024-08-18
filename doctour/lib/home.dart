import 'package:doctour/Consult.dart';
import 'package:doctour/Emergency_Call.dart';
import 'package:doctour/Healthcare.dart';
import 'package:doctour/Nearest_Health_Care.dart';
import 'package:doctour/affilaite.dart';
import 'package:doctour/certificate.dart';
import 'package:doctour/flight.dart';
import 'package:doctour/hotel.dart';
import 'package:doctour/ride.dart';
import 'package:flutter/material.dart';
import 'package:doctour/Booking.dart'; // Ensure this import is correct based on your file structure
import 'package:doctour/Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        // Navigate to Explore Page
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingPageMain()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmergencyCallScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorListPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePageMain()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome back, Angelina Leanore',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIconButton('Healthcare', 'assets/healthcare.png',
                          context, InsuranceApp()),
                      const SizedBox(width: 16),
                      buildIconButton(
                          'Affiliated',
                          'assets/affiliate-marketing.png',
                          context,
                          InsuranceAffiliationPage()),
                      const SizedBox(width: 16),
                      buildIconButton('Vaccination', 'assets/vaccine.png',
                          context, VaccinationCertificatePage()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIconButton('Flights', 'assets/travelling.png',
                          context, FlightBookingScreen()),
                      const SizedBox(width: 16),
                      buildIconButton('Hotels', 'assets/hotel.png', context,
                          HotelBookingPage()),
                      const SizedBox(width: 16),
                      buildIconButton('Rides', 'assets/transport.png', context,
                          MyHomePage()),
                      const SizedBox(width: 16),
                      buildIconButton('Nearest', 'assets/maps2.png', context,
                          HealthcareScreen()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  NewsCard(
                    image: 'assets/Screenshot 2024-08-17 004738.png',
                    title: 'Healthcare Tips',
                    description:
                        'To help you stay safe and enjoy your trip to the fullest, we\'ve compiled a list of important healthcare tips.',
                    dialogContent: [
                      buildTipItem(
                        'Pre-Travel Check-up:',
                        'Get a medical check-up before you travel to manage any existing conditions and address potential health risks at your destination.',
                      ),
                      buildTipItem(
                        'Vaccinations:',
                        'Check if your destination requires specific vaccinations, such as for yellow fever or typhoid, and get them well in advance.',
                      ),
                      buildTipItem(
                        'Pack Medications:',
                        'Bring enough prescription medication for your trip, including a few extra days\' worth, and keep a copy of your prescription handy.',
                      ),
                      buildTipItem(
                        'Stay Hydrated and Eat Safely:',
                        'Drink bottled water and choose well-cooked meals to avoid illness from unsafe food or water.',
                      ),
                      buildTipItem(
                        'Emergency Contacts:',
                        'Save important emergency numbers, including local healthcare facilities and your country\'s embassy, in your phone and keep a written copy.',
                      ),
                    ],
                  ),
                  NewsCard(
                    image: 'assets/Screenshot 2024-08-17 005006.png',
                    title: 'Health Advisories',
                    description: 'Dengue Fever Outbreak in Southeast Asia',
                    dialogContent: [
                      buildTipItem(
                        'About Dengue:',
                        'Dengue is a mosquito-borne viral infection causing flu-like illness, sometimes developing into severe dengue, which can be fatal.',
                      ),
                      buildTipItem(
                        'Symptoms:',
                        'Symptoms include high fever, severe headache, pain behind the eyes, joint and muscle pain, rash, and mild bleeding.',
                      ),
                      buildTipItem(
                        'Prevention:',
                        'Use mosquito repellents, wear long-sleeved clothing, and stay in places with air conditioning or window/door screens to keep mosquitoes out.',
                      ),
                      buildTipItem(
                        'Treatment:',
                        'There is no specific treatment for dengue. Seek medical advice, rest, drink fluids, and use pain relievers with acetaminophen.',
                      ),
                      buildTipItem(
                        'Emergency Contacts:',
                        'Seek immediate medical attention if you develop warning signs of severe dengue, such as severe abdominal pain, persistent vomiting, rapid breathing, or bleeding gums.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        iconSize: 24,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildIconButton(String label, String assetPath, BuildContext context,
      Widget destinationPage) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                assetPath,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final List<Widget> dialogContent;

  NewsCard({
    required this.image,
    required this.title,
    required this.description,
    required this.dialogContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blue.shade200, width: 1),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold), // Bold Title
            ),
            subtitle: Text(description),
            trailing: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewsDialog(
                      title: title,
                      image: image,
                      content: dialogContent,
                    );
                  },
                );
              },
              child: const Text('Learn More'),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsDialog extends StatelessWidget {
  final String title;
  final String image;
  final List<Widget> content;

  NewsDialog({
    required this.title,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(image, fit: BoxFit.cover),
            const SizedBox(height: 10),
            ...content,
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

Widget buildTipItem(String title, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.check_circle, color: Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title\n',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: description,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
