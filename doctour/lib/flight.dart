import 'package:flutter/material.dart';

void main() {
  runApp(FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlightBookingScreen(),
    );
  }
}

// Step 1: Create a model for flight details
class FlightDetail {
  final String flightClass;
  final String airline;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String baggageInfo;
  final String price;
  final String flightIcon;
  final String logo;

  FlightDetail({
    required this.flightClass,
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.baggageInfo,
    required this.price,
    required this.flightIcon,
    required this.logo,
  });
}

class FlightBookingScreen extends StatefulWidget {
  @override
  _FlightBookingScreenState createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  DateTime? _departDate;
  DateTime? _returnDate;
  final TextEditingController _departController = TextEditingController();
  final TextEditingController _returnController = TextEditingController();

  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  );

  @override
  void dispose() {
    _departController.dispose();
    _returnController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, DateTime? initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book a Flight',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Round-trip',
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
              ),
              items: ['Round-trip', 'One-way'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {},
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Flying from',
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                    ),
                  ),
                ),
                IconButton(
                  icon:
                      Image.asset('assets/shuffle.png', width: 40, height: 40),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Going to',
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _departController,
                    decoration: InputDecoration(
                      labelText: 'Depart',
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                    ),
                    readOnly: true,
                    onTap: () =>
                        _selectDate(context, _departController, _departDate),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _returnController,
                    decoration: InputDecoration(
                      labelText: 'Return',
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                    ),
                    readOnly: true,
                    onTap: () =>
                        _selectDate(context, _returnController, _returnDate),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Guests',
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
              ),
              readOnly: true,
              onTap: () {
                // Implement guests selection
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Promo code',
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to the search results screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResultScreen()),
                );
              },
              child: Text('Search',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue, // Color of the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Step 2: Create the SearchResultScreen

class SearchResultScreen extends StatelessWidget {
  final List<FlightDetail> flights = [
    FlightDetail(
      flightClass: 'Economy',
      airline: 'Indonesia AirAsia',
      departureTime: '05:00 CGK',
      arrivalTime: '08:05 KUL',
      duration: '2h 5m',
      baggageInfo: '7kg per guest',
      price: 'MYR 235',
      flightIcon: 'assets/AirAsia.png', // Replace with your flight icon path
      logo: 'assets/AirAsia.png', // Replace with your airline logo path
    ),
    FlightDetail(
      flightClass: 'Economy',
      airline: 'Indonesia AirAsia',
      departureTime: '06:35 CGK',
      arrivalTime: '09:40 KUL',
      duration: '2h 5m',
      baggageInfo: '7kg per guest',
      price: 'MYR 235',
      flightIcon: 'assets/AirAsia.png',
      logo: 'assets/AirAsia.png',
    ),
    FlightDetail(
      flightClass: 'Economy',
      airline: 'Indonesia AirAsia',
      departureTime: '07:10 CGK',
      arrivalTime: '10:15 KUL',
      duration: '2h 5m',
      baggageInfo: '7kg per guest',
      price: 'MYR 235',
      flightIcon: 'assets/AirAsia.png',
      logo: 'assets/AirAsia.png',
    ),
    FlightDetail(
      flightClass: 'Economy',
      airline: 'Batik Air',
      departureTime: '08:00 CGK',
      arrivalTime: '11:05 KUL',
      duration: '2h 5m',
      baggageInfo: '20kg per guest',
      price: 'MYR 298',
      flightIcon: 'assets/Batik.png',
      logo: 'assets/Batik.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Results',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: flights.length, // Number of search results
        itemBuilder: (context, index) {
          final flight = flights[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          flight.flightClass,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Depart: ${flight.airline}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 12), // Added extra space here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flight.departureTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(''),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(flight.flightIcon, width: 30),
                            Text(flight.duration),
                          ],
                        ),
                      ),
                      Text(
                        flight.arrivalTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(flight.baggageInfo),
                          SizedBox(height: 4),
                          Text(
                            flight.price,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        flight.logo,
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
