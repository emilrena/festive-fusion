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
import 'package:flutter/material.dart';

class MakeupNav extends StatefulWidget {
  const MakeupNav({super.key});

  @override
  State<MakeupNav> createState() => _MakeupNavState();
}

class _MakeupNavState extends State<MakeupNav> {
  int selectedindex=1;
   static const List<dynamic>option=[
    MakeupNotification(),
    MakeupHome(),
    Makeupresponce(),
    Makeup_EditProfile(),
    

   ];
   void ontop(int index){
    setState(() {
      selectedindex=index;
    });
   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: Center(child:option.
      elementAt(selectedindex),),
bottomNavigationBar: BottomNavigationBar(items: [
  BottomNavigationBarItem(icon: Icon(Icons.notification_add,),label: 'Notification'),

  BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'home'),
   BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart,),label: 'response'),

  BottomNavigationBarItem(icon: Icon(Icons.person),label: 'edit profile'),
],
type: BottomNavigationBarType.shifting,
currentIndex: selectedindex,
selectedItemColor: Color.fromARGB(255, 194, 47, 174),
unselectedItemColor: const Color.fromARGB(255, 13, 13, 14),
iconSize: 20,
onTap: ontop,
elevation: 5
),
    );
  }
}