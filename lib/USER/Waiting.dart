import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/USER/MakeupPayment.dart';
import 'package:festive_fusion/USER/ViewBookingStatus.dart';

class Waiting extends StatefulWidget {
  const Waiting({
    Key? key,
  }) : super(key: key);

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
    fetchBookings('');
  }

  void fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? '';
    });
  }

  void fetchBookings(String type) async {
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
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchProviderDetails(
      String type, String providerId) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(fontSize: 8),
                decoration: InputDecoration(
                  labelText: 'SEARCH',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
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
                        return CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        // Handle case where provider details are not found
                        return ListTile(
                          title: Text('Provider details not found'),
                        );
                      }

                      final providerData = snapshot.data!;
                      final providerName = providerData['name'];
                      final providerImage = providerData['image_url'];

                      return ListTile(
                        title: Text(providerName),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(providerImage),
                          radius: 30,
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            if (status == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MyBookingsStatus(
                                    providerName: providerName,
                                    providerImage: providerImage,
                                    packageId: booking['package_id'],
                                    providerId: providerId,
                                    type:type,
                                  );
                                }),
                              );
                            }
                          },
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
                            status == 0
                                ? 'Pending'
                                : (status == 1 ? 'Payment' : 'Rejected'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
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
    );
  }
}
