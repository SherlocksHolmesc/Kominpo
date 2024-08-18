import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'maschain.dart';

void main() {
  runApp(InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InsuranceHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InsuranceHomePage extends StatefulWidget {
  @override
  _InsuranceHomePageState createState() => _InsuranceHomePageState();
}

class _InsuranceHomePageState extends State<InsuranceHomePage> {
  final List<Map<String, dynamic>> _requests = [];

  void _addRequest(Map<String, dynamic> request) {
    setState(() {
      _requests.add(request);
    });
  }

  void _updateRequestStatus(int index, double newStatus) {
    setState(() {
      _requests[index]['status'] = newStatus;
    });
  }

  Future<void> _pickImage(Function(File?) onImagePicked) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Healthcare',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InsuranceCardSlider(),
            const SizedBox(height: 20),
            InsuranceTracking(
              addRequest: _addRequest,
              requests: _requests,
              updateRequestStatus: _updateRequestStatus,
              pickImage: _pickImage,
            ),
          ],
        ),
      ),
    );
  }
}

class InsuranceCardSlider extends StatelessWidget {
  final List<Map<String, String>> cards = [
    {
      'plan': 'PLAN1_INPATIENT',
      'name': 'LEANORE ANGELINA',
      'nric': 'Z012345',
      'status': 'Active',
    },
    {
      'plan': 'PLAN2_INPATIENT',
      'name': 'LEANORE ANGELINA',
      'nric': 'Z012332',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cards[index]['plan']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Name: ${cards[index]['name']}'),
                    Text('NRIC: ${cards[index]['nric']}'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        cards[index]['status']!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InsuranceTracking extends StatelessWidget {
  final Function addRequest;
  final Function updateRequestStatus;
  final List<Map<String, dynamic>> requests;
  final Future<void> Function(Function(File?)) pickImage;

  InsuranceTracking({
    required this.addRequest,
    required this.requests,
    required this.updateRequestStatus,
    required this.pickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Insurance Tracking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => _showAddRequestDialog(context),
            child: const Text(
              'Add a Request',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final status = requests[index]['status'] as double;
                return GestureDetector(
                  onTap: () => _showRequestDetails(
                    context,
                    index,
                    status,
                    requests[index]['id'],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: status,
                              min: 0.0,
                              max: 100.0,
                              divisions: 5,
                              label: '${status.toInt()}%',
                              onChanged: (value) {
                                // Progress slider can't be changed manually
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Text('${status.toInt()}%'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.lightBlue[50],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListTile(
                            title: const Text('Medical Insurance Request',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${requests[index]['id']}'),
                                Text('Date: ${requests[index]['date']}'),
                                Text(
                                    'Hospital: ${requests[index]['hospital']}'),
                              ],
                            ),
                            trailing: Text(
                              _getStatusLabel(status),
                              style: TextStyle(
                                color: _getStatusColor(status),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusLabel(double status) {
    if (status >= 10 && status < 30) {
      return 'Pending';
    } else if (status >= 30 && status < 50) {
      return 'Request Accepted';
    } else if (status >= 50 && status < 80) {
      return 'Treating';
    } else if (status >= 80 && status < 100) {
      return 'Upload Invoice';
    } else if (status == 100) {
      return 'Claim Approved';
    } else {
      return 'Unknown';
    }
  }

  Color _getStatusColor(double status) {
    if (status >= 10 && status < 30) {
      return Colors.grey;
    } else if (status >= 30 && status < 50) {
      return Colors.blue;
    } else if (status >= 50 && status < 80) {
      return Colors.orange;
    } else if (status >= 80 && status < 100) {
      return Colors.purple;
    } else if (status == 100) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  void _showRequestDetails(
      BuildContext context, int index, double status, String requestId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request ID: $requestId',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _getStatusLabel(status),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              if (status == 10)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    updateRequestStatus(index, 30.0);
                  },
                  child: const Text('Accept Request'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              if (status == 30)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    updateRequestStatus(index, 50.0);
                  },
                  child: const Text('Mark as Treating'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              if (status == 50)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    updateRequestStatus(index, 80.0);
                  },
                  child: const Text('Upload Invoice & Recommendations'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              if (status == 80)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        updateRequestStatus(index, 100.0);
                      },
                      child: const Text('Claim Approved'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Upload your invoice and medical letter from the doctor to proceed to the next step.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        // Use the pickImage function from the parent widget
                        await pickImage((file) {
                          // Handle the file
                        });
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload Invoice'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        // Use the pickImage function from the parent widget
                        await pickImage((file) {
                          // Handle the file
                        });
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload Photo'),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  void _showAddRequestDialog(BuildContext context) {
    final nameController = TextEditingController();
    final dateController = TextEditingController();
    final hospitalController = TextEditingController();
    final remarksController = TextEditingController();
    File? selectedCertificate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Medical Insurance Request'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Arrival Date'),
                ),
                TextField(
                  controller: hospitalController,
                  decoration:
                      const InputDecoration(labelText: 'Requested Hospital'),
                ),
                TextField(
                  controller: remarksController,
                  decoration:
                      const InputDecoration(labelText: 'Reasons of Visit'),
                ),
                const SizedBox(height: 20),
                const Text('Medical Certificate',
                    style: TextStyle(fontSize: 16)),
                ElevatedButton.icon(
                  onPressed: () async {
                    await pickImage((file) {
                      setState(() {
                        selectedCertificate = file;
                      });
                    });
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload'),
                ),
                if (selectedCertificate != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      selectedCertificate!,
                      height: 100,
                      width: 100,
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final request = {
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  'name': nameController.text,
                  'date': dateController.text,
                  'hospital': hospitalController.text,
                  'remarks': remarksController.text,
                  'status': 10.0,
                  'invoice': selectedCertificate?.path,
                };

                // Create audit trail
                final maschainService = MaschainService();
                try {
                  final success = await maschainService.createAuditTrail(
                      walletAddress:
                          '0x5CB9723A15b3a7b3C6175a91f89D1C7E93167a9E',
                      contractAddress:
                          '0x4706e74f048e3b80C1A6c9D291aE90fd2709111F',
                      metadata: {
                        'name': nameController.text,
                        'arrival_date': dateController.text,
                        'hospital': hospitalController.text,
                        'reason': remarksController.text,
                      },
                      callbackUrl: [
                        'https://webhook.site/16658f8a-2d54-4833-b6d8-5f4bd4a8317b'
                      ],
                      file: selectedCertificate);

                  if (success) {
                    addRequest(request);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Request added and stored in blockchain')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to store data in blockchain')),
                    );
                  }
                } catch (e) {
                  print("Error creating audit trail: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'An error occurred while processing your request')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void setState(Null Function() param0) {}
}
