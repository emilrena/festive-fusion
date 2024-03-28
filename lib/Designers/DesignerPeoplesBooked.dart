import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Designers/DesignerHome.dart';
import 'package:festive_fusion/Designers/DesignerProceeds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignerNotification extends StatefulWidget {
  const DesignerNotification({Key? key}) : super(key: key);

  @override
  State<DesignerNotification> createState() => _DesignerNotificationState();
}

class _DesignerNotificationState extends State<DesignerNotification> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> bookingRequests = [];

  @override
  void initState() {
    super.initState();
    fetchBookingRequests();
  }

  Future<void> fetchBookingRequests() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('uid') ?? '';

      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('requests')
          .where('provider_id', isEqualTo: id)
          .get();

      setState(() {
        bookingRequests = snapshot.docs;
      });

      print('Fetched ${bookingRequests.length} booking requests');
    } catch (e) {
      print('Error fetching booking requests: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('User_Registration')
          .doc(userId)
          .get();

      final userDetails = userSnapshot.data() ?? {};
      print('Fetched user details for userId: $userId');

      return userDetails;
    } catch (e) {
      print('Error fetching user details for userId: $userId - $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTIFICATIONS',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      body: ListView.builder(
        itemCount: bookingRequests.length,
        itemBuilder: (context, index) {
          final bookingRequest = bookingRequests[index];
          final userId = bookingRequest['user_id'];

          return FutureBuilder(
            future: fetchUserDetails(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                final userDetails = snapshot.data as Map<String, dynamic>;
                return Container(
                  height: 350,
                  width: 200,
                  margin: EdgeInsets.all(10),
                  color: Color(0xFFFFFFFF),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          userDetails.containsKey('image')
                              ? Image.network(userDetails['image_url'])
                              : SizedBox(), // Display image
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(userDetails['name'] ?? ''), // Display name
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'PACKAGE CHOOSED:',
                              style: TextStyle(color: Color.fromARGB(221, 83, 6, 77)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(bookingRequest['packageName'] ?? ''),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 250),
                        child: Text(
                          'Date : ${bookingRequest['date'] ?? ''}',
                          style: TextStyle(color: Color.fromARGB(255, 92, 8, 71)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 250),
                        child: Text(
                          'Time : ${bookingRequest['time'] ?? ''}',
                          style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: FutureBuilder(
                          future: fetchUserDetails(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              final userDetails = snapshot.data as Map<String, dynamic>;
                              return Text(
                                'Address : ${userDetails['address'] ?? ''}',
                                style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return DesignerProceed();
                                }));
                              },
                              icon: Icon(Icons.check),
                              color: Colors.deepPurple,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return DesignerHome();
                              }));
                            },
                            icon: Icon(Icons.cancel),
                            color: Colors.deepPurple,
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
