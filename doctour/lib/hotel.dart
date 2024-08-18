import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.lightBlueAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.blueAccent),
        ),
      ),
      home: HotelBookingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HotelBookingPage extends StatefulWidget {
  @override
  _HotelBookingPageState createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildHotelList(),
          ),
        ],
      ),
    );
  }
}

// Custom AppBar with additional features
AppBar _buildAppBar() {
  return AppBar(
    title: Text('HOTELS'),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
}

Widget _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search Location',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  );
}

Widget _buildHotelList() {
  return ListView.builder(
    itemCount: hotels.length,
    itemBuilder: (context, index) {
      return HotelCard(hotel: hotels[index]);
    },
  );
}

class Hotel {
  final List<String> imageUrls;
  final String name;
  final String location;
  final double rating;
  final double price;

  Hotel({
    required this.imageUrls,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrls: [
      'assets/seri pacific.jpeg',
      'assets/seri pacific 2.jpeg',
      'assets/seri pacific 3.jpeg'
    ],
    name: 'Seri Pacific Hotel Kuala Lumpur',
    location: 'Chow Kit',
    rating: 8.4,
    price: 342.54,
  ),
  Hotel(
    imageUrls: [
      'assets/sunway hotel.jpeg',
      'assets/sunway hotel 2.jpeg',
      'assets/sunway hotel 3.jpeg'
    ],
    name: 'Sunway Putra Hotel Kuala Lumpur',
    location: 'Chow Kit',
    rating: 8.6,
    price: 459.00,
  ),
  Hotel(
    imageUrls: [
      'assets/grand_hyatt.jpeg',
      'assets/grandhyatt2.jpeg',
      'assets/grandhyatt2.jpeg',
      'assets/grandhyatt3.jpeg'
    ],
    name: 'Grand Hyatt Kuala Lumpur',
    location: 'Jalan Pinang, Kuala Lumpur',
    rating: 9.8,
    price: 799.33,
  ),
  Hotel(
    imageUrls: ['assets/garden_hotel.jpeg', 'assets/garden_hotel.jpeg'],
    name: 'The Gardens Hotel & Residences Kuala Lumpur',
    location: 'Mid Valley City, Kuala Lumpur',
    rating: 8.2,
    price: 599.33,
  ),
  Hotel(
    imageUrls: ['assets/westin_hotel.jpeg', 'assets/westin_hotel.jpeg'],
    name: 'The Westin Kuala Lumpur',
    location: 'Jalan Bukit Bintang, Kuala Lumpur',
    rating: 8.8,
    price: 850.33,
  ),
];

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  const HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
              ),
              items: hotel.imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                hotel.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(
                hotel.location,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      hotel.rating.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'From MYR ${hotel.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailPage(hotel: hotel),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailPage({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                ),
                items: hotel.imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Location: ${hotel.location}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Price per night: MYR ${hotel.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Rating: ${hotel.rating}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking action here
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
