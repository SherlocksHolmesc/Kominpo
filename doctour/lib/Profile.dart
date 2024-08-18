import 'package:flutter/material.dart';
import 'package:doctour/home.dart'; // Import other screens
import 'package:doctour/booking.dart';
import 'package:doctour/emergency_call.dart';
import 'package:doctour/Consult.dart'; // Assuming you have a file for DoctorListPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePageMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePageMain extends StatefulWidget {
  @override
  _ProfilePageMainState createState() => _ProfilePageMainState();
}

class _ProfilePageMainState extends State<ProfilePageMain> {
  int _currentIndex = 4;

  final List<Widget> _pages = [
    HomePage(),
    BookingPageMain(),
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
      body: Stack(
        children: <Widget>[
          _buildBackgroundCurve(),
          Column(
            children: <Widget>[
              const SizedBox(height: 60),
              _buildProfileHeader(),
              Expanded(
                child: _buildListSection(context),
              ),
            ],
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

  Widget _buildBackgroundCurve() {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: 350.0,
        color: const Color.fromARGB(255, 108, 200, 243),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Z012345',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildExpansionTile(
                context, Icons.account_circle, "My Account Information"),
            _buildExpansionTile(context, Icons.payment, "Payments & wallets"),
            _buildExpansionTile(
                context, Icons.local_hospital, "Medical Information"),
            _buildExpansionTile(context, Icons.history, "Booking History"),
            _buildExpansionTile(
                context, Icons.phone_in_talk, "Emergency Call Set Up"),
            _buildExpansionTile(context, Icons.language, "Change Language"),
            _buildExpansionTile(context, Icons.settings, "Settings"),
            _buildExpansionTile(context, Icons.feedback, "Feedback"),
            _buildExpansionTile(
                context, Icons.support_agent, "Customer Support"),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log out', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Implement the logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(
      BuildContext context, IconData icon, String title) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(title),
        children: <Widget>[
          ListTile(
            title: Text('Edit $title'),
            onTap: () {
              // Implement the edit functionality for each section
            },
          ),
        ],
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 80);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
