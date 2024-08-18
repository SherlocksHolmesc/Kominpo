import 'dart:async';
import 'package:flutter/material.dart';

class EmergencyCallScreen extends StatefulWidget {
  @override
  _EmergencyCallScreenState createState() => _EmergencyCallScreenState();
}

class _EmergencyCallScreenState extends State<EmergencyCallScreen> {
  bool isMutePressed = false;
  bool isSpeakerPressed = false;
  bool isAddCallPressed = false;
  bool isVideoCallPressed = false;
  bool isKeypadPressed = false;
  bool isContactPressed = false;

  String? _activeButton;

  int _dotCount = 1;
  String _callingText = "Emergency Call";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startDotAnimation();
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount % 4) + 1;
        _callingText = "Emergency Call${"." * _dotCount}";
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onButtonPressed(String buttonName) {
    setState(() {
      if (_activeButton == buttonName) {
        _activeButton = null;
      } else {
        _activeButton = buttonName;
      }
      _updateButtonStates();
    });
  }

  void _updateButtonStates() {
    isMutePressed = _activeButton == 'Mute';
    isSpeakerPressed = _activeButton == 'Speaker';
    isAddCallPressed = _activeButton == 'Add Call';
    isVideoCallPressed = _activeButton == 'Video Call';
    isKeypadPressed = _activeButton == 'Keypad';
    isContactPressed = _activeButton == 'Contact';
  }

  void _endCall() {
    Navigator.pop(context); // Close the emergency call page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _callingText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "00:00",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 40),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCircleButton(
                  Icons.mic_off,
                  'Mute',
                  isMutePressed,
                  () => _onButtonPressed('Mute'),
                ),
                _buildCircleButton(
                  Icons.dialpad,
                  'Keypad',
                  isKeypadPressed,
                  () => _onButtonPressed('Keypad'),
                ),
                _buildCircleButton(
                  Icons.volume_up,
                  'Speaker',
                  isSpeakerPressed,
                  () => _onButtonPressed('Speaker'),
                ),
                _buildCircleButton(
                  Icons.add_call,
                  'Add Call',
                  isAddCallPressed,
                  () => _onButtonPressed('Add Call'),
                ),
                _buildCircleButton(
                  Icons.videocam,
                  'Video Call',
                  isVideoCallPressed,
                  () => _onButtonPressed('Video Call'),
                ),
                _buildCircleButton(
                  Icons.contact_phone,
                  'Contact',
                  isContactPressed,
                  () => _onButtonPressed('Contact'),
                ),
              ],
            ),
            SizedBox(height: 50),
            FloatingActionButton(
              onPressed: _endCall, // Close the page when pressed
              backgroundColor: Colors.red,
              child: Icon(Icons.call_end, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(
      IconData icon, String label, bool isPressed, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isPressed ? Colors.blue : Colors.grey[800],
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
