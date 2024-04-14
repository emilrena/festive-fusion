import 'package:festive_fusion/USER/BookedPeoples.dart';
import 'package:festive_fusion/USER/UserHome.dart';
import 'package:festive_fusion/USER/Waiting.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/edit_profile.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/registration.dart';
import 'package:flutter/material.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int selectedindex=2;
   final String uid = 'uid';
   static const List<dynamic>option=[
    MyBookings(),
    Waiting(),
    UserHome(),
    Edit(),
    

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
  BottomNavigationBarItem(icon: Icon(Icons.book_online,),label: 'booking'),

   BottomNavigationBarItem(icon: Icon(Icons.notification_important_sharp,),label: 'booking status'),

  BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'home'),

  BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'person')

  

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