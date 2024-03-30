import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/USER/MakeupPayment.dart';

class MyBookingsStatus extends StatefulWidget {
  final String providerName;
  final String providerImage;
  final String packageId;
  final String providerId;
  final String type;

  const MyBookingsStatus({
    Key? key,
    required this.providerName,
    required this.providerImage,
    required this.packageId,
    required this.providerId,
    required this.type,
  }) : super(key: key);

  @override
  State<MyBookingsStatus> createState() => _MyBookingsStatusState();
}

class _MyBookingsStatusState extends State<MyBookingsStatus> {
  String? description; // Variable to store the package description

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchPackageDetails(
      String packageId) async {
    try {
      String collectionName;

      // Determine collection based on the type
      if (widget.type == 'designer') {
        collectionName = ' designer_package ';
      } else if (widget.type == 'mehandi') {
        collectionName = 'mehandi_package';
      } else if (widget.type == 'makeup') {
        collectionName = 'makeup_package';
      } else {
        // Default collection or handle other types
        collectionName = 'default_collection';
      }

      // Fetch data from the determined collection
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(collectionName)
          .doc(packageId)
          .get();

      return snapshot;
    } catch (error) {
      // Handle any potential errors
      print("Error fetching package details: $error");
      throw error; // Rethrow the error for higher-level handling if necessary
    }
  }

  String? userAddress;
  String? userDistrict;
  String? userState;
  String? userPin;

  @override
  void initState() {
    super.initState();
    _getUserAddress();
    _fetchPackageDetails(); // Call _fetchPackageDetails to fetch package details
  }

  Future<void> _getUserAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userAddress = prefs.getString('adress');
      userDistrict = prefs.getString('district');
      userState = prefs.getString('state');
      userPin = prefs.getString('pin');
    });
  }

  Future<void> _fetchPackageDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fetchPackageDetails(widget.packageId);
      setState(() {
        description = snapshot.data()!['description']; // Assign description value
      });
    } catch (error) {
      // Handle any potential errors
      print("Error fetching package details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTIFICATIONS',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      body: Container(
        height: 600,
        width: 400,
        margin: EdgeInsets.all(10),
        color: Color(0xFFFFFFFF),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.providerImage),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(widget.providerName),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'PACKAGE CHOOSED:',
                    style: TextStyle(color: Color.fromARGB(221, 83, 6, 77)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: fetchPackageDetails(widget.packageId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Package details not found');
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(snapshot.data!['package']),
                );
              },
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    'TOTAL AMOUNT:',
                    style: TextStyle(color: Color.fromARGB(221, 83, 6, 77)),
                  ),
                  SizedBox(width: 10),
                  Text(
                    description ?? 'No description',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 240),
              child: Text(
                'Address :  ',
                style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userAddress ?? 'User Address not found'),
                  Text(userDistrict ?? 'User District not found'),
                  Text(userState ?? 'User State not found'),
                  Text(userPin ?? 'User PIN not found'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Payment(
                      provider_id: widget.providerId,
                      package_id: widget.packageId,
                      type: widget.type,
                      description: description??'' // Pass description to Payment page
                    ),
                  ),
                );
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
