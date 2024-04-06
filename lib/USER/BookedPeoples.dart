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
  String? userId;
  double rating = 0;
  

  @override
  void initState() {
    super.initState();
    fetchUserId();
    fetchBookings('');
    fetchRentalBookings(); 

  }

 void fetchUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? fetchedUserId = prefs.getString('user_id') ?? '';
  print('Fetched userId: $fetchedUserId'); // Add this line
  setState(() {
    userId = fetchedUserId;
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
  void fetchRentalBookings() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? userId = sp.getString('uid');

  if (userId == null) {
    print('User ID not found in shared preferences');
    return;
  }

  print('Fetching rental bookings for user ID: $userId');
  Query query = FirebaseFirestore.instance
      .collection('rental_booking')
      .where('user_id', isEqualTo: userId);
      print(userId);

  final QuerySnapshot snapshot = await query.get();

  if (snapshot.docs.isEmpty) {
    print('No rental bookings found for user ID: $userId');
  } else {
    print('Rental bookings found: ${snapshot.docs.length}');
  }

  setState(() {
    var rentalBookings = snapshot.docs;
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
                    : ListView.builder(
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

                              return Card(
                                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          providerName,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
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
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                          child: Text('Feedback'),
                                        ),
                                      ),
                                      SizedBox(height: 8), // Add some space between ListTile and buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
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
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                            child: Text('Complaint'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ),
            RentTabContent(userId: userId),
          ],
        ),
      ),
    );
  }
}

class RentTabContent extends StatelessWidget {
  final String? userId;

  RentTabContent({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('rental_bookings')
          .where('user_id', isEqualTo: userId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print('No rental bookings found.');
          return Center(child: Text('No rental bookings found.'));
        }

        print('Rental bookings found: ${snapshot.data!.docs.length}');
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final rental = snapshot.data!.docs[index];
            final date = rental['date'] ?? '';
            final description = rental['description'] ?? '';
            final imageUrl = rental['imageUrl'] ?? '';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: $date'),
                  Text('Description: $description'),
                  Image.network(imageUrl),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
