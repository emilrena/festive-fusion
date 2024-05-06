import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignerEnquiry extends StatefulWidget {
  const DesignerEnquiry({Key? key});

  @override
  State<DesignerEnquiry> createState() => _DesignerEnquiryState();
}

class _DesignerEnquiryState extends State<DesignerEnquiry> {
  late String loggedInUserId;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _getLoggedInUserId();
  }

  Future<void> _getLoggedInUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInUserId = prefs.getString('uid') ?? '';
    });
    // Update designer_id field in Firestore
    await FirebaseFirestore.instance
        .collection('customizedbookings')
        .where('user_id', isEqualTo: loggedInUserId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'designer_id': loggedInUserId});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Designer Enquiries'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customizedbookings')
            .where('designer_id', isEqualTo: loggedInUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final booking = documents[index];
                final userId = booking['user_id'];
                final description = booking['description'];
                final bustSize = booking['bust_size'];
                final length = booking['length'];
                final waistSize = booking['waist_size'];
                final contactNumber = booking['contact_number'];
                final dateTime = booking['dateTime'];
                final date = booking['date'];
                final imageUrl = booking['image_url'];
                final status = booking['status'];

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('User_Registration')
                      .doc(userId)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (userSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${userSnapshot.error}'));
                    }

                    if (userSnapshot.hasData &&
                        userSnapshot.data != null) {
                      final userData =
                          userSnapshot.data!;
                      final userName = userData['name'];
                      final userImageUrl = userData['image_url'];

                      return Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userImageUrl),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('Description: $description'),
                              Text('Bust Size: $bustSize'),
                              Text('Length: $length'),
                              Text('Waist Size: $waistSize'),
                              Text('Contact Number: $contactNumber'),
                              Text('Date & Time: $dateTime'),
                              Text('Date: $date'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (status == 0)
                                    ElevatedButton(
                                      onPressed: () {
                                        _showAcceptDialog(
                                            context,
                                            userId,
                                            booking.reference);
                                      },
                                      child: Text('Accept'),
                                    )
                                  else
                                    ElevatedButton(
                                      onPressed: null,
                                      child: Text('Accepted'),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.green),
                                    ),
                                  if (status == 0)
                                    ElevatedButton(
                                      onPressed: () {
                                        _deleteView(
                                            booking.reference);
                                      },
                                      child: Text('Reject'),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red),
                                    )
                                  else
                                    SizedBox(),
                                ],
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FullScreenImage(
                                          imageUrl: imageUrl),
                                ),
                              );
                            },
                            child: imageUrl != null
                                ? Image.network(imageUrl)
                                : SizedBox.shrink(),
                          ),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}'));
          }

          return Center(
              child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showAcceptDialog(BuildContext context, String userId,
      DocumentReference bookingRef) {
    TextEditingController amountController = TextEditingController();
    TextEditingController detailsController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Accept Booking'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                            labelText: 'Total Amount'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter total amount';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: detailsController,
                        decoration: InputDecoration(labelText: 'Details'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Delivery Date'),
                        trailing: Text(selectedDate == null
                            ? 'Select Date'
                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
                        onTap: () async {
                          final DateTime? pickedDate =
                              await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(
                                DateTime.now().year + 1),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveToCustomCollection(amountController.text,
                          detailsController.text, selectedDate, userId, bookingRef);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveToCustomCollection(String amount, String details,
      DateTime? deliveryDate, String userId, DocumentReference bookingRef) async {
    try {
      await FirebaseFirestore.instance
          .collection('custom_collection')
          .add({
        'user_id': userId,
        'designer_id': loggedInUserId, // Save logged-in user's UID as designer_id
        'delivery_date': deliveryDate,
        'total_amount': amount,
        'description': details,
        'status':1,
      });

      await bookingRef.update({'status': 1});

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking accepted and saved successfully.')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error saving booking: $e')));
    }
  }

  void _deleteView(DocumentReference reference) {
    reference.delete();
  }
}

class FullScreenImage extends StatelessWidget {
  final String? imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: imageUrl != null ? Image.network(imageUrl!) : SizedBox.shrink(),
      ),
    );
  }
}
