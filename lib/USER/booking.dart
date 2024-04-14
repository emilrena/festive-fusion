import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/USER/MakeupPayment.dart';

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
  var waitingForResponse = false;
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
    FirebaseFirestore.instance
        .collection('designer_package')
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
      print('Error fetching makeup package details: $error');
    });
  }

  void getSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('Adress');
      state = prefs.getString('state');
      pin = prefs.getString('pin');
      district = prefs.getString('District');
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Time:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 10),
                    Text(
                      '${selectedTime.format(context)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10),
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selected Package:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Package Name: $packageName',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Package Description: $packageDescription',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Current Address:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address: $address',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'State: $state',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pin: $pin',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'District: $district',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: waitingForResponse
                    ? null
                    : () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        var userId = sp.getString('uid');
                        String dateAsString =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        String timeAsString = DateFormat('HH:mm').format(
                          DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          ),
                        );

                        setState(() {
                          waitingForResponse = true;
                        });

                        try {
                          DocumentReference docRef =
                              await FirebaseFirestore.instance
                                  .collection('requests')
                                  .add({
                            'user_id': userId,
                            'package_id': widget.package_id,
                            'provider_id': widget.provider_id,
                            'date': dateAsString,
                            'time': timeAsString.toString(),
                            'status': 0,
                            'type': widget.type,
                          });
                          setState(() {
                            requestDocumentId = docRef.id;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Availability request sent successfully!'),
                            ),
                          );
                        } catch (error) {
                          print('Error sending availability request: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to send availability request. Please try again later.',
                              ),
                            ),
                          );
                        }
                      },
                child: waitingForResponse
                    ? Text(
                        'Waiting for provider response...',
                        style: TextStyle(color: Color.fromARGB(255, 85, 24, 82)),
                      )
                    : Text(
                        'Check Availability',
                        style: TextStyle(color: Color.fromARGB(255, 128, 34, 96)),
                      ),
              ),
              if (requestDocumentId != null)
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .doc(requestDocumentId)
                      .snapshots(),
                  builder: (cPontext, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      int? status = snapshot.data?['status'];
                      if (status == 0) {
                        return Text(
                          'Waiting for provider response...',
                          style: TextStyle(fontSize: 16),
                        );
                      } else if (status == 1) {
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Payment(
                                  package_id: widget.package_id,
                                  provider_id: widget.provider_id,
                                  type: widget.type,
                                  description: packageDescription,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Proceed to Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (status == 2) {
                        return Column(
                          children: [
                            Text(
                              'Request rejected.',
                              style: TextStyle(fontSize: 16),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Select a different option',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text(
                          'Status: $status',
                          style: TextStyle(fontSize: 16),
                        );
                      }
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
