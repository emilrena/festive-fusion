import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CustomizedPage extends StatefulWidget {
  final String receiverId;
  const CustomizedPage({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<CustomizedPage> createState() => _CustomizedPageState();
}

class _CustomizedPageState extends State<CustomizedPage> {
  File? _image;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _bustSizeController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();
  TextEditingController _waistSizeController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isLoading = false;
   String ?uid;

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  Future<void> _loadUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid') ?? '';
    });
  }

  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _sendRequest() async {
    setState(() {
      isLoading = true; // Set loading state to true
    });

    try {
      // Convert TimeOfDay to DateTime
      DateTime? selectedDateTime;
      if (selectedDate != null && selectedTime != null) {
        selectedDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        );
      }

      // Upload image to Firebase Storage
      String imageUrl = '';
      if (_image != null) {
        Reference ref = FirebaseStorage.instance.ref().child('images').child('customized_${DateTime.now().millisecondsSinceEpoch}.jpg');
        UploadTask uploadTask = ref.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      // Save details to Firestore
      await FirebaseFirestore.instance.collection('customizedbookings').add({
        'designer_id': widget.receiverId,
        'user_id': uid,
        'description': _descriptionController.text,
        'bust_size': _bustSizeController.text,
        'length': _lengthController.text,
        'waist_size': _waistSizeController.text,
        'contact_number': _contactNumberController.text,
        'status': 0,
        'date': selectedDate.toString(),
        'dateTime': selectedDateTime?.toString(),
        'image_url': imageUrl,
      });

      // Show success message or navigate to success page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request sent successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to designer work page
      Navigator.pushReplacementNamed(context, '/DesignerWork');
    } catch (e) {
      print('Error sending request: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send request. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Set loading state to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customized Page'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Customize Request'),
              Tab(text: 'Status'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _image == null
                        ? Center(child: Text('No image selected'))
                        : Image.file(_image!),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Upload Image'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 100,
                          child: TextField(
                            controller: _bustSizeController,
                            decoration: InputDecoration(
                              labelText: 'Bust Size',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: 100,
                          child: TextField(
                            controller: _lengthController,
                            decoration: InputDecoration(
                              labelText: 'Length',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: 100,
                          child: TextField(
                            controller: _waistSizeController,
                            decoration: InputDecoration(
                              labelText: 'Waist Size',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _contactNumberController,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 5),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Text(
                            selectedDate == null ? 'Select Date' : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                            style: TextStyle(color: selectedDate == null ? Colors.grey : Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedTime = pickedTime;
                              });
                            }
                          },
                          child: Text(
                            selectedTime == null ? 'Select Time' : '${selectedTime!.hour}:${selectedTime!.minute}',
                            style: TextStyle(color: selectedTime == null ? Colors.grey : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : _sendRequest,
                    child: isLoading ? CircularProgressIndicator() : Text('Send Request'),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('custom_collection')
                  .where('designer_id', isEqualTo: widget.receiverId)
                  .where('user_id', isEqualTo: uid) // Filter by user_id (UID from shared preferences)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;
                return ListView.builder(
  itemCount: documents.length,
  itemBuilder: (context, index) {
    final booking = documents[index];
    final status = booking['status'];
    final designerId = booking['designer_id'];

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('designer register').doc(designerId).get(),
      builder: (context, designerSnapshot) {
        if (designerSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (designerSnapshot.hasError) {
          return Center(child: Text('Error: ${designerSnapshot.error}'));
        }

        if (designerSnapshot.hasData && designerSnapshot.data != null) {
          final designerData = designerSnapshot.data!;
          final designerName = designerData['name'];
          final designerImageUrl = designerData['image_url'];

          // Additional details
          final totalAmount = booking['total_amount'];
          final description = booking['description'];
          final deliveryDate = booking['delivery_date'];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(designerImageUrl),
              ),
              title: Text(designerName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (status == 1) ...[
                    Text('Total Amount: $totalAmount'),
                    Text('Description: $description'),
                    Text('Delivery Date: $deliveryDate'),
                  ]
                ],
              ),
              // Add other details if needed
              trailing: status == 1
                  ? ElevatedButton(
                      onPressed: () {
                        // Handle payment
                      },
                      child: Text('View Total Amount'),
                    )
                  : null,
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
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
