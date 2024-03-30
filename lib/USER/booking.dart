import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:festive_fusion/USER/MakeupPayment.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booked extends StatefulWidget {
  final String provider_id;
  final String package_id;
  final String type;

  Booked({
    Key? key,
    required this.provider_id,
    required this.package_id,
    required this.type,
  }) : super(key: key);

  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {
  late DateTime selectedDate = DateTime.now();
  var selectedTime = TimeOfDay.now();

  late String packageName = '';
  late String packageDescription = '';
  String? address;
  String? state;
  String? pin;
  String? district;
  // var img
  var waitingForResponse = 0;
  String? requestDocumentId;

  @override
  void initState() {
    super.initState();
    fetchPackageDetails();
    getSavedAddress();
  }

  void fetchPackageDetails() {
    if (widget.type == 'designer') {
      fetchDesignerPackageDetails();
    } else if (widget.type == 'mehandi') {
      fetchMehandiPackageDetails();
    } else if (widget.type == 'makeup') {
      fetchMakeupPackageDetails();
    }
  }

  void fetchDesignerPackageDetails() {
    print('object');
    FirebaseFirestore.instance
        .collection(' designer_package ')
        .doc(widget.package_id)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          packageName = doc['package'];
          packageDescription = doc['description'];
        });
      }
    }).catchError((error) {
      print('Error fetching designer package details: $error');
    });
  }

  void fetchMehandiPackageDetails() {
    FirebaseFirestore.instance
        .collection('mehandi_package')
        .doc(widget.package_id)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          packageName = doc['package'];
          packageDescription = doc['description'];
        });
      }
    }).catchError((error) {
      print('Error fetching mehandi package details: $error');
    });
  }

  void fetchMakeupPackageDetails() {
    FirebaseFirestore.instance
        .collection('makeup_package')
        .doc(widget.package_id)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          packageName = doc['package'];
          packageDescription = doc['description'];
        });
      }
    }).catchError((error) {
      print('Error fetching mehandi package details: $error');
    });
  }

  void getSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('Adress');
      state = prefs.getString('state');
      pin = prefs.getString('pin');
      district = prefs.getString('district');
      // img = prefs.get('image_url');
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                width: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text('TIME:'),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Text(
                            '${selectedTime.format(context)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('DATE:'),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 30,
                    ),
                    Text('SELECTED PACKAGE:'),
                    Container(
                      height: 80,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 206, 221),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Package Name: $packageName',
                              style: TextStyle(fontSize: 16)),
                          Text('Package Description: $packageDescription',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: Text('CHANGE')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('CURRENT ADDRESS:'),
                    Container(
                      height: 160,
                      width: 300,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 206, 221),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address: $address',
                              style: TextStyle(fontSize: 16)),
                          Text('State: $state', style: TextStyle(fontSize: 16)),
                          Text('Pin: $pin', style: TextStyle(fontSize: 16)),
                          Text('District: $district',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: Text('CHANGE')),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        var a = sp.getString('uid');
                        print('..........$a');
                        // Change the UI to waiting status
                      
                        String dateAsString =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        String timeAsString = DateFormat('HH:mm').format(
                            DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute));
                        await FirebaseFirestore.instance
                            .collection('requests')
                            .add({
                          'user_id': a,
                          'package_id': widget.package_id,
                          'provider_id': widget.provider_id,
                          'date': dateAsString,
                          'packageName':packageName,
                          
                          'time': timeAsString.toString(),
                          'status': 0,
                           'type': widget.type,
                          
                          
                          
                        });
                          setState(() {
                          // Update UI to indicate waiting status
                          waitingForResponse = 1;
                              // Assuming you have a boolean variable to track waiting status
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Availability request sent!')),
                        );

                       
                      },
                      child: waitingForResponse==1
                          ? Text(
                              'Waiting for provider response...') // Show waiting status
                          : Text('Check Availability',
                              style: TextStyle(color: Colors.deepPurple)),
                    ),

// Display a message or UI based on the status of the request
                    // StreamBuilder<DocumentSnapshot>(
                    //   stream: FirebaseFirestore.instance
                    //       .collection('requests')
                    //       .doc(requestDocumentId)
                    //       .snapshots(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       // Show a loading indicator while waiting for the data
                    //       return CircularProgressIndicator();
                    //     } else {
                    //       // Check the status field of the document
                    //       int? status = snapshot.data?['status'];
                    //       if (status == 0) {

                    //         return Text('Waiting for provider response...');
                    //       } else if (status == 1) {

                    //         return ElevatedButton(
                    //           onPressed: () {
                    //             Navigator.push(context,
                    //                 MaterialPageRoute(builder: (context) {
                    //               return Payment(
                    //                 package_id: widget.package_id,
                    //                 provider_id: widget.provider_id,
                    //                 type: widget.type,
                    //                 description: packageDescription,
                    //               );
                    //             }));
                    //           },
                    //           child: Text('NEXT',
                    //               style: TextStyle(color: Colors.deepPurple)),
                    //         );
                    //       } else if (status == 2) {
                    //         return Column(
                    //           children: [
                    //             Text('Request rejected.'),
                    //             ElevatedButton(
                    //               onPressed: () {},
                    //               child: Text('Select Designer',
                    //                   style:
                    //                       TextStyle(color: Colors.deepPurple)),
                    //             ),
                    //           ],
                    //         );
                    //       } else {
                    //         return Text('Status: $status');
                    //       }
                    //     }
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
