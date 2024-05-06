import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignerNotification extends StatefulWidget {
  const DesignerNotification({Key? key}) : super(key: key);

  @override
  State<DesignerNotification> createState() => _DesignerNotificationState();
}

class _DesignerNotificationState extends State<DesignerNotification> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> bookingRequests = [];
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> payments = [];

  @override
  void initState() {
    super.initState();
    fetchBookingRequests();
    fetchPayments();
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString('uid') ?? '';

      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('provider_id', isEqualTo: uid) // Filter payments by provider_id
          .get();

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
  Future<Map<String, dynamic>> fetchPackageDetails(String package_id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> packageSnapshot = await FirebaseFirestore.instance
          .collection(' designer_package ')
          .doc(package_id)
          .get();

      final packageDetails = packageSnapshot.data() ?? {};
      print('Fetched package details for packageId: $package_id');

      return packageDetails;
    } catch (e) {
      print('Error fetching package details for packageId: $package_id - $e');
      return {};
    }
  }

  Future<void> acceptBooking(BuildContext context, String requestId, String userId, String packageId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String designerId = prefs.getString('uid') ?? '';

      // Fetch package details using packageId
      final packageDetails = await fetchPackageDetails(packageId);

      // Display the package name and description from packageDetails
      String packageName = packageDetails['package'] ?? '';
      String packageDescription = packageDetails['description'] ?? '';

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController deliveryDateController = TextEditingController();
          return AlertDialog(
            title: Text("Enter Delivery Date"),
            content: TextField(
              controller: deliveryDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "YYYY-MM-DD",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String deliveryDate = deliveryDateController.text;
                  if (deliveryDate.isNotEmpty) {
                    // Close the dialog
                    Navigator.of(context).pop();
                    
                    // Update the booking status
                    await FirebaseFirestore.instance.collection('requests').doc(requestId).update({
                      'status': 1, // 1 indicates booking accepted
                    });

                    // Store the delivery date, package name, and package description in the designer_delivery collection
                    await FirebaseFirestore.instance.collection('designer_delivery').doc(requestId).set({
                      'request_id': requestId,
                      'user_id': userId, // Pass the userId
                      'designer_id': designerId, // Save the designer ID
                      'delivery_date': deliveryDate,
                      'package_name': packageName,
                      'package_description': packageDescription,
                    });

                    // Fetch updated requests
                    fetchBookingRequests();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          );
        },
      );
      print('Booking request accepted');
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
            'Designer',
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
                final packageId = bookingRequest['package_id']; // Add this line

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
                              FutureBuilder(
                                future: fetchPackageDetails(packageId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    final packageDetails = snapshot.data as Map<String, dynamic>;
                                    return Text(
                                      packageDetails['package'] ?? '',
                                      style: TextStyle(fontSize: 16),
                                    );
                                  }
                                },
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
                                            acceptBooking(context, requestId, userId, bookingRequest['package_id'] ?? '');
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
                                'Address: ${userDetails['Adress'] ?? ''}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Phone No: ${userDetails['mobile no'] ?? ''}',
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
