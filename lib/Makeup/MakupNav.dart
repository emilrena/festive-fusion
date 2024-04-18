import 'package:festive_fusion/common%20screens/UserType.dart';
import 'package:flutter/material.dart';
import 'package:festive_fusion/ADMIN/AdminComplaintView.dart';
import 'package:festive_fusion/ADMIN/AdminDesignerView.dart';
import 'package:festive_fusion/ADMIN/AdminHome.dart';
import 'package:festive_fusion/Designers/DesignerEditProfile.dart';
// import 'package:festive_fusion/Designers/MakeupHome.dart';
import 'package:festive_fusion/Designers/DesignerPeoplesBooked.dart';
import 'package:festive_fusion/Makeup/BookingNotification.dart';
import 'package:festive_fusion/Makeup/MakeupFeedbackComplaint.dart';
import 'package:festive_fusion/Makeup/MakeupHome.dart';
import 'package:festive_fusion/Makeup/Makeup_editProfile.dart';
import 'package:festive_fusion/USER/BookedPeoples.dart';
import 'package:festive_fusion/USER/UserHome.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/registration.dart';

class MakeupNav extends StatefulWidget {
  const MakeupNav({Key? key}) : super(key: key);

  @override
  State<MakeupNav> createState() => _MakeupNavState();
}

class _MakeupNavState extends State<MakeupNav> {
  int _selectedIndex = 1;

  static const List<Widget> _options = [
    MakeupNotification(),
    MakeupHome(),
    Makeupresponce(),
    Makeup_EditProfile(),
    // Add more options here
  ];

  void _onTop(int index) {
    if (index == 4) {
      // Logout option selected
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => TypeUser()),
        (Route<dynamic> route) => false, // Remove all routes until this one
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Response',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Edit Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Logout',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 194, 47, 174),
        unselectedItemColor: const Color.fromARGB(255, 13, 13, 14),
        iconSize: 20,
        onTap: _onTop,
        elevation: 5,
      ),
    );
  }
}
