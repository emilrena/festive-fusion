import 'package:festive_fusion/ADMIN/AdminDesignerView.dart';
import 'package:festive_fusion/ADMIN/AdminMakeupView.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeupFullProfile extends StatefulWidget {
  final String makeup_id;
  const MakeupFullProfile({Key? key, required this.makeup_id})
      : super(key: key);

  @override
  State<MakeupFullProfile> createState() => _MakeupFullProfileState();
}

class _MakeupFullProfileState extends State<MakeupFullProfile> {
  bool isBlocked = false;
  Map<String, dynamic>? makeupDetails;

  // Function to fetch makeup artist details from Firestore
  Future<void> fetchMakeupDetails() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Makeup register')
          .doc(widget.makeup_id)
          .get();
      setState(() {
        makeupDetails = snapshot.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      print('Error fetching makeup artist details: $e');
    }
  }

  // Function to update status to 1 and block the makeup artist
  void blockMakeupArtist() async {
    try {
      await FirebaseFirestore.instance
          .collection('Makeup register')
          .doc(widget.makeup_id)
          .update({'status': 1});
      setState(() {
        isBlocked = true;
      });
    } catch (e) {
      print('Error blocking makeup artist: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMakeupDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Your app bar content goes here
          ),
      body: Center(
        child: makeupDetails == null
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(makeupDetails!['image_url'] ?? ''),
                      ),
                      SizedBox(height: 20),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Name'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['name'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Email'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['email'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Gender'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['gender'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Address'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['Address'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('District'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['District'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                  child: Center(child: Text('Mobile No'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['mobile no'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('Pin'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['pin'] ?? 'Not available'}')),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Center(child: Text('State'))),
                              TableCell(
                                  child: Text(
                                      '${makeupDetails!['state'] ?? 'Not available'}')),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isBlocked
                            ? null // Disable button if makeup artist is blocked
                            : () {
                                // Call function to block makeup artist
                                blockMakeupArtist();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminMakeupView(),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          backgroundColor:
                              isBlocked ? Colors.grey : Colors.deepPurple,
                        ),
                        child: Text(
                          'BLOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
