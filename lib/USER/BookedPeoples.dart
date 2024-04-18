import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<QueryDocumentSnapshot>? bookings;
  List<QueryDocumentSnapshot>? rentalBookings;
  String? userId;
  double rating = 0;
  var id;
  String complaint = '';

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  void fetchUserId() async {
    SharedPreferences spr = await SharedPreferences.getInstance();
    setState(() {
      id = spr.getString('uid');
      if (id != null) {
        fetchBookings('');
        fetchRentalBookings();
      }
    });
  }

  void fetchBookings(String type) async {
    if (id == null) return; // Return if id is null

    Query query = FirebaseFirestore.instance
        .collection('payments')
        .where('user_id', isEqualTo: id);
    if (type.isNotEmpty) {
      query = query.where('type', isEqualTo: type);
    }

    final QuerySnapshot snapshot = await query.get();

    setState(() {
      bookings = snapshot.docs;
    });
  }

  void fetchRentalBookings() async {
    if (id == null) return; // Return if id is null

    print('Fetching rental bookings for user ID: $id');
    Query query = FirebaseFirestore.instance
        .collection('rental_booking')
        .where('user_id', isEqualTo: id);

    final QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      print('No rental bookings found for user ID: $id');
    } else {
      print('Rental bookings found: ${snapshot.docs.length}');
    }

    setState(() {
      rentalBookings = snapshot.docs;
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
      collectionName = 'Makeup register';
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

  void submitFeedback(
      String providerId, String providerName, String type) async {
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

//   void showDeliveryStatus(String designer_id, String type) async {
//   // Fetch delivery details from 'designer_delivery' collection
//   final deliverySnapshot = await FirebaseFirestore.instance
//       .collection('designer_delivery')
//       .doc(designer_id)
//       .get();

//   // Check if the document exists and if the required fields exist
//   if (deliverySnapshot.exists) {
//     final deliveryDate = deliverySnapshot.data()?['delivery_date'];
//     final packageName = deliverySnapshot.data()?['package_name'];

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delivery Status'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Delivery Date: $deliveryDate'),
//               Text('Package Name: $packageName'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     // Handle case where the document does not exist
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delivery Status'),
//           content: Text('Delivery details not found.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Bookings'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Booked'),
              Tab(text: 'Rent'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: SafeArea(
                child: bookings == null
                    ? Center(child: CircularProgressIndicator())
                    : TabBarView(
  children: [
    Scaffold(
      body: SafeArea(
        child: bookings == null
            ? Center(child: CircularProgressIndicator())
            :  ListView.builder(
  itemCount: bookings!.length,
  itemBuilder: (context, index) {
    final booking = bookings![index];
    final type = booking['type'];
    final providerId = booking['provider_id'];

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: fetchProviderDetails(type, providerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(providerImage),
                      radius: 30,
                    ),
                    title: Text(
                      providerName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Add spacing
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
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
                                        submitComplaint(
                                          providerId,
                                          type,
                                          complaint,
                                        );
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
                            foregroundColor: Colors.white, backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Complaint'),
                        ),
                        ElevatedButton(
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
                                        itemPadding: EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
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
                                        submitFeedback(
                                          providerId,
                                          providerName,
                                          type,
                                        );
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
                            foregroundColor: Colors.white, backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Feedback'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
),


      ),
    ),
  ],
),
              )),
            Scaffold(
              body: SafeArea(
                child: rentalBookings == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: rentalBookings!.length,
                        itemBuilder: (context, index) {
                          final rental = rentalBookings![index];
                          final imageUrl = rental['imageUrl'] ?? '';
                          final description = rental['description'] ?? '';
                          final rate = rental['rate'] ?? '';
                          final rentalId =
                              rental['rental_id'] ?? ''; // Get rental_id
                          final time = 'pickup: after 10 days';

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   'Rental ID: $rentalId', // Display rental_id
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: 16,
                                        //   ),
                                        // ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Description:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          description,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rate: $rate',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              time,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                // Fetch the current rental ID from the rental_booking collection
                                                // DocumentSnapshot snapshot =
                                                //     await FirebaseFirestore.instance
                                                //         .collection('rental_booking')
                                                //         .doc(rental_id)
                                                //         .get();
                                                // String rentalId = snapshot['rental_id']; // Assuming 'rental_id' is the field name in your rental_booking collection

                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    String complaintText =
                                                        ''; // Variable to hold the complaint text
                                                    return AlertDialog(
                                                      title: Text("Complaint"),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                              "Please describe your complaint"),
                                                          TextField(
                                                            onChanged: (value) {
                                                              complaintText =
                                                                  value; // Update complaint text as user types
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Complaint',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String userId =
                                                                prefs.getString(
                                                                        'uid') ??
                                                                    '';
                                                            String userName =
                                                                prefs.getString(
                                                                        'name') ??
                                                                    '';

                                                            // Store complaint in Firestore
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'complaints')
                                                                .add({
                                                              'provider_id':
                                                                  rentalId,
                                                              'name': userName,
                                                              'complaint':
                                                                  complaintText,
                                                              'type': 'rental',
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close dialog
                                                          },
                                                          child: Text('Submit'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close dialog
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text('Complaint'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                // Fetch the current rental ID from the rental_booking collection
                                                // DocumentSnapshot snapshot =
                                                //     await FirebaseFirestore
                                                //         .instance
                                                //         .collection(
                                                //             'rental_booking')
                                                //         .doc(rental_id)
                                                //         .get();
                                                // Assuming 'rental_id' is the field name in your rental_booking collection

                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Feedback"),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                              "Rate your experience"),
                                                          RatingBar.builder(
                                                            initialRating:
                                                                rating,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemSize: 20,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.purple,
                                                            ),
                                                            onRatingUpdate:
                                                                (value) {
                                                              setState(() {
                                                                rating = value;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String userName =
                                                                prefs.getString(
                                                                        'name') ??
                                                                    '';

                                                            // Store feedback in Firestore with rental ID
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'feedback')
                                                                .add({
                                                             'provider_id':
                                                                  rentalId,
                                                              'name': userName,
                                                              'rating': rating,
                                                              'type': 'rental',
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close dialog
                                                          },
                                                          child: Text('Submit'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close dialog
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text('Feedback'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
