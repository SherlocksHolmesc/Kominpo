import 'package:doctour/Emergency_Call.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blueAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue[50],
          prefixIconColor: Colors.blue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[200]!, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: InsuranceAffiliationPage(),
    );
  }
}

class InsuranceAffiliationPage extends StatefulWidget {
  @override
  _InsuranceAffiliationPageState createState() =>
      _InsuranceAffiliationPageState();
}

class _InsuranceAffiliationPageState extends State<InsuranceAffiliationPage> {
  int _selectedIndex = 0;

  final List<Insurance> insuranceCompanies = [
    Insurance('Prudential', 'assets/pruden.jpeg', [
      'Pantai Hospital Kuala Lumpur',
      'Gleneagles Hospital Kuala Lumpur',
      'Prince Court Medical Centre',
      'Subang Jaya Medical Centre',
      'KPJ Ampang Puteri Specialist Hospital',
      'Sunway Medical Centre'
    ]),
    Insurance('AXA', 'assets/axa.png', [
      'Assunta Hospital, Petaling Jaya',
      'Island Hospital, Penang',
      'Loh Guan Lye Specialists Centre, Penang',
      'KPJ Tawakkal Health Centre, Kuala Lumpur',
      'Pantai Hospital Ayer Keroh, Melaka',
      'Mahkota Medical Centre, Melaka'
    ]),
    Insurance('Allianz', 'assets/alianz.png', [
      'Gleneagles Hospital Kuala Lumpur - Kuala Lumpur',
      'Pantai Hospital Kuala Lumpur - Kuala Lumpur',
      'Assunta Hospital - Petaling Jaya, Selangor',
      'Penang Adventist Hospital - Penang',
      'Tropicana Medical Centre - Kota Damansara, Selangor',
      'ParkCity Medical Centre - Kuala Lumpur'
    ]),
    Insurance('AIA', 'assets/aia.png', [
      'Pantai Hospital Kuala Lumpur',
      'KPJ Damansara Specialist Medical Centre ',
      'Sunway Medical Centre',
      'Gleneagles Kuala Lumpur',
      'KPJ Sabah Specialist Medical Centre ',
      'Hospital Cengal '
    ]),
    Insurance('Manulife', 'assets/manulife.png', [
      'Pantai Hospital Kuala Lumpur',
      'KPJ Damansara Specialist Medical Centre ',
      'Sunway Medical Centre',
      'Gleneagles Kuala Lumpur',
      'KPJ Sabah Specialist Medical Centre ',
      'Hospital Cengal '
    ]),
    Insurance('Etiqa', 'assets/etiqa.png', [
      'Pantai Hospital Kuala Lumpur',
      'KPJ Damansara Specialist Medical Centre ',
      'Sunway Medical Centre',
      'Gleneagles Kuala Lumpur',
      'KPJ Sabah Specialist Medical Centre ',
      'Hospital Cengal '
    ]),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmergencyCallScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('Insurance Hospital Affiliation'),
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: insuranceCompanies.length,
                itemBuilder: (context, index) {
                  final insurance = insuranceCompanies[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) =>
                            HospitalListSheet(insurance: insurance),
                      );
                    },
                    child: Card(
                      color: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(insurance.logoPath,
                              width: 60, height: 60),
                          SizedBox(height: 10),
                          Text(insurance.name,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blue[800])),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Text('Other Pages Content'),
            ),
    );
  }
}

class HospitalListSheet extends StatelessWidget {
  final Insurance insurance;

  HospitalListSheet({required this.insurance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 146, 190, 225),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Hospitals Affiliated with ${insurance.name}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Hospital',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: insurance.hospitals.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    title: Text(insurance.hospitals[index]),
                    contentPadding: EdgeInsets.all(10),
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

class Insurance {
  final String name;
  final String logoPath;
  final List<String> hospitals;

  Insurance(this.name, this.logoPath, this.hospitals);
}
