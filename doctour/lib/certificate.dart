import 'package:doctour/Emergency_Call.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaccination Certificate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VaccinationCertificatePage(),
    );
  }
}

class VaccinationCertificatePage extends StatefulWidget {
  @override
  _VaccinationCertificatePageState createState() =>
      _VaccinationCertificatePageState();
}

class _VaccinationCertificatePageState
    extends State<VaccinationCertificatePage> {
  int _selectedIndex = 0;
  String? _selectedVaccinationTitle;
  String? _selectedVaccinationLocation;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        // Navigate to EmergencyCallScreen when Emergency tab is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmergencyCallScreen()),
        );
      } else {
        _selectedIndex = index;
        _selectedVaccinationTitle = null;
        _selectedVaccinationLocation = null;
      }
    });
  }

  void _showVaccinationDetails(String title, String location) {
    setState(() {
      _selectedVaccinationTitle = title;
      _selectedVaccinationLocation = location;
    });
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return ExplorePage(onCardTap: _showVaccinationDetails);
      case 1:
        return BookingPage();
      case 3:
        return ConsultPage();
      case 4:
        return ProfilePage();
      default:
        return Center(child: Text('Page not found'));
    }
  }

  Widget _buildVaccinationDetailsBox() {
    if (_selectedVaccinationTitle == null ||
        _selectedVaccinationLocation == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.blue[700], // Bolder blue color for the detail box
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedVaccinationTitle!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Location: $_selectedVaccinationLocation',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              Text('Angelina Leanore', style: TextStyle(color: Colors.white)),
              Text('***1234567890***', style: TextStyle(color: Colors.white)),
              Text('12-08-2000', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Booster 1\nCovid-19 Vaccine Pfizer\n2022-07-09\nCheras',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Image.asset(
                    'assets/qr rickroll.png', // Replace with your QR code asset
                    width: 80,
                    height: 80,
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedVaccinationTitle = null;
                    _selectedVaccinationLocation = null;
                  });
                },
                child: Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination Certificate'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[100], // Light baby blue for AppBar
      ),
      body: Container(
        color: Colors.lightBlue[50], // Light blue background for the page
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: _buildPageContent(),
              ),
            ),
            if (_selectedIndex == 0) _buildVaccinationDetailsBox(),
          ],
        ),
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  final Function(String, String) onCardTap;

  ExplorePage({required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          VaccinationCardWidget(
            title: 'First Vaccination',
            location: 'Cheras',
            onTap: onCardTap,
          ),
          SizedBox(height: 16),
          VaccinationCardWidget(
            title: 'Second Vaccination',
            location: 'Selangor',
            onTap: onCardTap,
          ),
          SizedBox(height: 16),
          VaccinationCardWidget(
            title: 'Third Vaccination',
            location: 'Kuala Lumpur',
            onTap: onCardTap,
          ),
        ],
      ),
    );
  }
}

class VaccinationCardWidget extends StatelessWidget {
  final String title;
  final String location;
  final Function(String, String) onTap;

  VaccinationCardWidget({
    required this.title,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.lightBlue[100], // Light baby blue for Vaccination cards
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        leading: Icon(Icons.medical_services, size: 40, color: Colors.blue),
        title: Text(title, style: TextStyle(fontSize: 18, color: Colors.blue)),
        subtitle: Text(location, style: TextStyle(color: Colors.blue)),
        onTap: () {
          onTap(title, location);
        },
      ),
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
