import 'package:flutter/material.dart';
import 'package:doctour/home.dart'; // Import other screens
import 'package:doctour/booking.dart';
import 'package:doctour/emergency_call.dart';
import 'package:doctour/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Consultation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DoctorListPage extends StatefulWidget {
  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  int _currentIndex = 3;

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
      appBar: AppBar(
        title: const Text(
          'Pre-consult with our Certified Doctor',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10.0),
            DoctorCard(
              name: 'Dr Emilia Chua Siew Li',
              gender: 'Female',
              languages: 'English, Bahasa Malaysia, Mandarin',
              qualification: 'BDS (India), MFDS RCS (Edinburgh)',
              imageAssetPath: 'assets/lec1.jpg',
              onConsult: () {
                _showChat(context, 'Dr Emilia Chua Siew Li');
              },
            ),
            const SizedBox(height: 10.0),
            DoctorCard(
              name: 'Dr Bong Jan Jin',
              gender: 'Male',
              languages: 'English, Bahasa Malaysia, Mandarin, Hokkien',
              qualification:
                  'MB ChB (Leeds, UK), Doctorate of Medicine (UK), MRCS (Edin), JCIE(UK)',
              imageAssetPath: 'assets/lec2.jpg',
              onConsult: () {
                _showChat(context, 'Dr Bong Jan Jin');
              },
            ),
            const SizedBox(height: 10.0),
            DoctorCard(
              name: 'Dr Robert Patrick Jalleh',
              gender: 'Male',
              languages: 'English, Bahasa Malaysia, Cantonese',
              qualification:
                  'MBBS (Mal), FAMM, FACS, FRCS (Edin), FRCS (Glasg), FRCS (Ire)',
              imageAssetPath: 'assets/lec3.jpg',
              onConsult: () {
                _showChat(context, 'Dr Robert Patrick Jalleh');
              },
            ),
            const SizedBox(height: 10.0),
            DoctorCard(
              name: 'Dr Rosnawati Binti Yahya',
              gender: 'Female',
              languages: 'English, Bahasa Malaysia',
              qualification:
                  'BSC (Medical Science), MBCh B (Hons), MRCP (UK), FRCP (Edinburgh)',
              imageAssetPath: 'assets/lec4.jpg',
              onConsult: () {
                _showChat(context, 'Dr Rosnawati Binti Yahya');
              },
            ),
            const SizedBox(height: 10.0),
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

  void _showChat(BuildContext context, String doctorName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ChatPage(doctorName: doctorName);
      },
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String gender;
  final String languages;
  final String qualification;
  final String imageAssetPath;
  final VoidCallback onConsult;

  DoctorCard({
    required this.name,
    required this.gender,
    required this.languages,
    required this.qualification,
    required this.imageAssetPath,
    required this.onConsult,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.blue, width: 1.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 100, // Width of the square image
              height: 120, // Height of the square image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAssetPath),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: rounded corners
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                      'Gender: $gender\nLanguages: $languages\nQualification: $qualification'),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: onConsult,
                    child: const Text('Consult'),
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

class ChatPage extends StatefulWidget {
  final String doctorName;

  ChatPage({required this.doctorName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> _chatMessages = [];
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      _chatMessages.add({'text': text, 'isDoctor': false, 'sender': 'You'});
      Future.delayed(const Duration(seconds: 1), () {
        _chatMessages.add({
          'text': _generateDoctorResponse(text),
          'isDoctor': true,
          'sender': widget.doctorName,
        });
      });
    });

    _messageController.clear();
  }

  String _generateDoctorResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();
    if (userMessage.contains('headache')) {
      return "I’m sorry to hear that you’re not feeling well. On a scale of 1 to 10, how severe would you say your headache is?";
    } else if (userMessage.contains('7')) {
      return "Thank you for sharing that. Does the headache happen at a specific time of day, or does anything seem to trigger it, like stress or certain foods?";
    } else if (userMessage.contains('afternoon') ||
        userMessage.contains('screen')) {
      return "It sounds like your headache might be related to eye strain. Try taking regular breaks from your screen and see if that helps. Anything else you'd like to discuss?";
    } else {
      return "Thank you for your message. How can I assist further?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                'Pre-consult with ${widget.doctorName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      text: _chatMessages[index]['text'],
                      isDoctor: _chatMessages[index]['isDoctor'],
                      sender: _chatMessages[index]['sender'],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        _sendMessage(_messageController.text);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isDoctor;
  final String sender;

  ChatBubble({
    required this.text,
    required this.isDoctor,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isDoctor ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isDoctor ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(sender, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            decoration: BoxDecoration(
              color: isDoctor ? Colors.blue.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
