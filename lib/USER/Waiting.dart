import 'package:festive_fusion/USER/MakeupPayment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Waiting extends StatefulWidget {
  final String package_id;
  final String provider_id;
  final String type;
  const Waiting( {Key? key,
    required this.provider_id,
    required this.package_id,
    required this.type,
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
      print('____________________________$bookings');
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchProviderDetails(
      String type, String providerId) async {
    String collectionName;

    // Determine the collection based on the type
    if (type == 'mehandi') {
      collectionName = 'mehandi_register';
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
                itemCount: bookings!.length,
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
                        onTap: () {
                          if (status == 1) {
                            // Navigate to the payment page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Payment(
                                  provider_id: providerId,
                                  package_id:
                                      packageId, // Assuming you have a variable named packageId
                                  type: type,
                                  description: description,
                                );
                              }),
                            );
                          }
                        },
                        title: Text(providerName),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(providerImage),
                          radius: 30,
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {},
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
