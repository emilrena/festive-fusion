import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<QueryDocumentSnapshot>? bookings;
  String? userId;
  double rating = 0;

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
        .collection('payments')
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

  void submitFeedback(String providerId, String providerName, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('name');

    if (userName != null) {
      // Save feedback data to Firestore
      await FirebaseFirestore.instance.collection('feedback').add({
        'provider_id': providerId,
        'name': userName,
        'type': type,
        'rating': rating,
      });

      Navigator.of(context).pop(); // Close the feedback dialog
    } else {
      // Handle case where user name is not found in SharedPreferences
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('User name not found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void submitComplaint(String providerId, String type, String complaint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('name');

    if (userName != null) {
      // Save complaint data to Firestore
      await FirebaseFirestore.instance.collection('complaints').add({
        'provider_id': providerId,
        'name': userName,
        'type': type,
        'complaint': complaint,
      });

      Navigator.of(context).pop(); // Close the complaint dialog
    } else {
      // Handle case where user name is not found in SharedPreferences
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('User name not found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bookings'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                style: TextStyle(fontSize: 8),
                decoration: InputDecoration(
                    labelText: 'SEARCH', border: OutlineInputBorder()),
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

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(providerName),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(providerImage),
                              radius: 30,
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Feedback"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Rate your experience"),
                                          RatingBar.builder(
                                            initialRating: rating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.purple,
                                            ),
                                            onRatingUpdate: (value) {
                                              setState(() {
                                                rating = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            submitFeedback(providerId, providerName, type);
                                          },
                                          child: Text('Submit'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 88, 40, 172),
                              ),
                              child: Text(
                                'FEEDBACK',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 107, 10, 86),
                                    fontSize: 10),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(''),
                            trailing: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String complaint = '';
                                    return AlertDialog(
                                      title: Text("Complaint"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Please describe your complaint"),
                                          TextField(
                                            onChanged: (value) {
                                              complaint = value;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Complaint',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            submitComplaint(providerId, type, complaint);
                                          },
                                          child: Text('Submit'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                'COMPLAINT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10),
                              ),
                            ),
                          ),
                        ],
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
