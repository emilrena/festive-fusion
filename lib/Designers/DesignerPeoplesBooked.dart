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
          return Container(
            height: 350,
            width: 200,
            margin: EdgeInsets.all(10),
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('Assets/p4.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(bookingRequest['name'] ?? ''),
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
                  child: Text(bookingRequest['package_name'] ?? ''),
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
                  child: Text(
                    'Address : ${bookingRequest['address'] ?? ''}',
                    style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),
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
        },
      ),
    );
  }
}
