import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RentalFullProfile extends StatefulWidget {
  final String rental_id;
  const RentalFullProfile({Key? key, required this.rental_id}) : super(key: key);

  @override
  State<RentalFullProfile> createState() => _RentalFullProfileState();
}

class _RentalFullProfileState extends State<RentalFullProfile> {
  Future<DocumentSnapshot>? _rentalFuture;

  @override
  void initState() {
    super.initState();
    _rentalFuture = _getRentalData();
  }

  Future<DocumentSnapshot> _getRentalData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Rental register')
          .doc(widget.rental_id)
          .get();
      return documentSnapshot;
    } catch (e) {
      print('Error fetching designer data: $e');
      throw e; // Re-throw the error to handle it in the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot>(
        future: _rentalFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data == null || !snapshot.data!.exists) {
              return Center(child: Text('No data found'));
            }
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String imageUrl = data['image_url'] ?? '';
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Name'))),
                              TableCell(child: Text('${data['name']}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Email'))),
                              TableCell(child: Text('${data['email']}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Gender'))),
                              TableCell(child: Text('${data['gender']}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Address'))),
                              TableCell(child: Text('${data['Adress']}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Experience'))),
                              TableCell(child: Text('${data['experience']} years')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('State'))),
                              TableCell(child: Text('${data['state']}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Phone No'))),
                              TableCell(child: Text('${data['mobile no']}')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement block functionality
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), backgroundColor: Colors.red,
                      ),
                      child: Text(
                        'Block ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
