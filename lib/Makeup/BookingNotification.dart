import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
 // Import FirebaseAuth

class MakeupNotification extends StatefulWidget {
  const MakeupNotification({Key? key}) : super(key: key);

  @override
  State<MakeupNotification> createState() => _MakeupNotificationState();
}

class _MakeupNotificationState extends State<MakeupNotification> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> bookingRequests = [];
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> payments = [];
  late String currentUserID = '';

  @override
  void initState() {
    super.initState();
    fetchUserID();
    fetchBookingRequests();
    fetchPayments();
  }

  Future<void> fetchUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserID = prefs.getString('uid') ?? '';
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

  Future<void> fetchPayments() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('payments').where('user_id', isEqualTo: currentUserID).get();

      setState(() {
        payments = snapshot.docs;
      });

      print('Fetched ${payments.length} payments');
    } catch (e) {
      print('Error fetching payments: $e');
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

  Future<void> acceptBooking(String requestId) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(requestId).update({
        'status': 1, // 1 indicates booking accepted
      });
      print('Booking request accepted');
      // After accepting, fetch updated requests
      fetchBookingRequests();
    } catch (e) {
      print('Error accepting booking request: $e');
    }
  }

  Future<void> cancelBooking(String requestId) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(requestId).update({
        'status': 2, // 2 indicates booking cancelled
      });
      print('Booking request cancelled');
      // After cancelling, fetch updated requests
      fetchBookingRequests();
    } catch (e) {
      print('Error cancelling booking request: $e');
    }
  }

  Future<void> deleteBooking(String requestId) async {
    try {
      await FirebaseFirestore.instance.collection('requests').doc(requestId).delete();
      print('Booking request deleted');
      // After deleting, fetch updated requests
      fetchBookingRequests();
    } catch (e) {
      print('Error deleting booking request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'makeup',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.deepPurpleAccent),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Notifications'),
              Tab(text: 'Committed Work'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: bookingRequests.length,
              itemBuilder: (context, index) {
                final bookingRequest = bookingRequests[index].data();
                final userId = bookingRequest['user_id'];
                final requestId = bookingRequests[index].id;
                final status = bookingRequest['status'];

                return FutureBuilder(
                  future: fetchUserDetails(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final userDetails = snapshot.data as Map<String, dynamic>;
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(userDetails['image_url'] ?? ''),
                                    radius: 30,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    userDetails['name'] ?? '',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Package Chosen:',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                bookingRequest['package'] ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Date: ${bookingRequest['date'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Time: ${bookingRequest['time'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Address: ${userDetails['Adress'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (status == 0) // Show only if the status is pending
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            acceptBooking(requestId);
                                          },
                                          child: Text(
                                            'ACCEPT',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        TextButton(
                                          onPressed: () {
                                            cancelBooking(requestId);
                                          },
                                          child: Text(
                                            'DECLINE',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (status == 1) // Show only if the status is accepted
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Accepted'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: () {
                                      deleteBooking(requestId);
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index].data();
                final userId = payment['user_id'];

                if (userId != currentUserID) {
                  // If the payment is not related to the current user, don't display it
                  return SizedBox.shrink();
                }

                return FutureBuilder(
                  future: fetchUserDetails(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final userDetails = snapshot.data as Map<String, dynamic>;
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description: ${payment['description'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Payment Type: ${payment['payment_type'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'User Details:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Name: ${userDetails['name'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Address: ${userDetails['address'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Phone No: ${userDetails['phone_no'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}