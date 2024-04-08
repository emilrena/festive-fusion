import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/USER/MakeupPayment.dart';
import 'package:festive_fusion/USER/ViewBookingStatus.dart';

class Waiting extends StatefulWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  List<QueryDocumentSnapshot>? bookings;
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  void fetchUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userId = prefs.getString('uid');
      });
      if (userId != null) {
        fetchBookings('');
      }
    } catch (error) {
      print('Error fetching user ID: $error');
      // Handle error appropriately, e.g., show a dialog to the user
    }
  }

  void fetchBookings(String type) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection('requests')
          .where('user_id', isEqualTo: userId);
      if (type.isNotEmpty) {
        query = query.where('type', isEqualTo: type);
      }

      final QuerySnapshot snapshot = await query.get();

      setState(() {
        bookings = snapshot.docs;
      });
    } catch (error) {
      print('Error fetching bookings: $error');
      // Handle error appropriately, e.g., show a dialog to the user
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchProviderDetails(
      String type, String providerId) async {
    try {
      String collectionName;

      // Determine the collection based on the type
      if (type == 'mehandi') {
        collectionName = 'Mehandi register';
      } else if (type == 'designer') {
        collectionName = 'designer register';
      } else if (type == 'makeup') {
        collectionName = 'makeup_register';
      } else {
        collectionName = 'default_collection';
      }

      // Fetch data from the determined collection
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(providerId)
              .get();

      return snapshot;
    } catch (error) {
      print('Error fetching provider details: $error');
      throw error; // Rethrow the error to handle it outside this function
    }
  }

  Future<String?> fetchPaymentStatus(String providerId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('payments')
              .where('provider_id', isEqualTo: providerId)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first['status'];
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching payment status: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: bookings?.length ?? 0,
                  itemBuilder: (context, index) {
                    final booking = bookings![index];
                    final type = booking['type'];
                    final providerId = booking['provider_id'];
                    final status = booking['status'];

                    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: fetchProviderDetails(type, providerId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error fetching provider details'),
                          );
                        }

                        final providerData = snapshot.data!;
                        final providerName = providerData['name'];
                        final providerImage = providerData['image_url'];

                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(providerImage),
                              radius: 30,
                            ),
                            title: Text(
                              providerName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              status == 0
                                  ? 'Status: Pending'
                                  : (status == 1 ? 'Status: Payment' : 'Status: Rejected'),
                              style: TextStyle(
                                color: status == 0
                                    ? Colors.grey
                                    : (status == 1 ? Colors.blue : Colors.red),
                              ),
                            ),
                            trailing: FutureBuilder<String?>(
                              future: fetchPaymentStatus(providerId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return SizedBox(); // Return an empty SizedBox if an error occurs
                                }
                                final paymentStatus = snapshot.data;

                                return ElevatedButton(
                                  onPressed: paymentStatus != 'Paid'
                                      ? () {
                                          if (status == 1) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) {
                                                return MyBookingsStatus(
                                                  providerName: providerName,
                                                  providerImage: providerImage,
                                                  packageId: booking['package_id'],
                                                  providerId: providerId,
                                                  type: type,
                                                );
                                              }),
                                            );
                                          }
                                        }
                                      : null, // Disable button if payment status is 'Paid'
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 16.0,
                                    ),
                                    backgroundColor: status == 0
                                        ? Colors.grey // Pending
                                        : (status == 1
                                            ? Colors.blue // Payment
                                            : Colors.red), // Rejected
                                  ),
                                  child: Text(
                                    status == 0 ? 'Pending' : (status == 1 ? 'Payment' : 'Rejected'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
