import 'package:festive_fusion/ADMIN/AdminComplaintView.dart';
import 'package:festive_fusion/ADMIN/AdminDesignerView.dart';
import 'package:festive_fusion/ADMIN/AdminHome.dart';
import 'package:festive_fusion/USER/BookedPeoples.dart';
import 'package:festive_fusion/USER/UserHome.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/common%20screens/UserType.dart';
import 'package:festive_fusion/registration.dart';
import 'package:flutter/material.dart';

class AdminNav extends StatefulWidget {
  const AdminNav({Key? key}) : super(key: key);

  @override
  State<AdminNav> createState() => _AdminNavState();
}

class _AdminNavState extends State<AdminNav> {
  int selectedindex = 1;
  static const List<Widget> options = [
    ComplaintView(),
    AdminHome(),
  ];

  void ontop(int index) {
    setState(() {
      if (index == 2) {
        // Logout action
        // Navigate to the registration page
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => TypeUser()),
          (route) => false,
        );
      } else {
        selectedindex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: options.elementAt(selectedindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.error),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Logout',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedindex,
        selectedItemColor: Color.fromARGB(255, 194, 47, 174),
        unselectedItemColor: const Color.fromARGB(255, 13, 13, 14),
        iconSize: 20,
        onTap: ontop,
        elevation: 5,
      ),
    );
  }
}
