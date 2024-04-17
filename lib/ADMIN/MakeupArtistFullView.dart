import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeupFullProfile extends StatefulWidget {
  final String makeup_id;
  const MakeupFullProfile({Key? key, required this.makeup_id}) : super(key: key);

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
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(makeupDetails!['image_url'] ?? ''),
                  ),
                  SizedBox(height: 30),
                  Text('Name: ${makeupDetails!['name'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('Email: ${makeupDetails!['email'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('Gender: ${makeupDetails!['gender'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('Address: ${makeupDetails!['Address'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('District: ${makeupDetails!['District'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('Mobile No: ${makeupDetails!['Mobile no'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('Pin: ${makeupDetails!['pin'] ?? 'Not available'}'),
                  SizedBox(height: 20),
                  Text('State: ${makeupDetails!['state'] ?? 'Not available'}'),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: isBlocked
                        ? null // Disable button if makeup artist is blocked
                        : () {
                            // Call function to block makeup artist
                            blockMakeupArtist();
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      backgroundColor: isBlocked ? Colors.grey : Colors.deepPurple,
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
    );
  }
}
