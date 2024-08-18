import 'package:flutter/material.dart';

void main() {
  runApp(DoctPayApp());
}

class DoctPayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctPayScreen(),
    );
  }
}

class DoctPayScreen extends StatefulWidget {
  @override
  _DoctPayScreenState createState() => _DoctPayScreenState();
}

class _DoctPayScreenState extends State<DoctPayScreen> {
  double balance = 100.00; // Initial balance
  double selectedAmount = 0.00; // Selected amount to be added

  void _addAmount(double amount) {
    setState(() {
      selectedAmount += amount; // Add the selected amount to the current amount
    });
  }

  void _confirmAmount() {
    setState(() {
      balance += selectedAmount; // Update the balance with the selected amount
      selectedAmount = 0.00; // Reset the selected amount
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'DocPay',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          child: Column(
            children: [
              // Balance Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Color(0xFFE7F3F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Balance',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'RM${balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.qr_code_scanner, color: Colors.black, size: 32),
                        SizedBox(height: 4),
                        Text(
                          'Scan to Pay',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 55),
              // Amount Input Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'RM${selectedAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(Icons.edit, color: Colors.blue),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Amount Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildAmountButton('RM5', 5.00),
                        _buildAmountButton('RM25', 25.00),
                        _buildAmountButton('RM50', 50.00),
                        _buildAmountButton('RM75', 75.00),
                        _buildAmountButton('RM100', 100.00),
                        _buildAmountButton('RM150', 150.00),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Payment Method Section
                    Row(
                      children: [
                        Image.asset(
                          'assets/visalogo.png',
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Visa 1234',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Radio(
                          value: true,
                          groupValue: true,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Confirm Button
              ElevatedButton(
                onPressed: _confirmAmount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(String label, double amount) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          _addAmount(amount);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
