import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/registration.dart';
import 'package:flutter/material.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int selectedindex=0;
   static const List<dynamic>option=[
    Booked(),
    Message(),
    Registration(),

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

  BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'home'),

  BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'person')
],
type: BottomNavigationBarType.shifting,
currentIndex: selectedindex,
selectedItemColor: Colors.deepPurpleAccent,
unselectedItemColor: Colors.blue,
iconSize: 20,
onTap: ontop,
elevation: 5
),
    );
  }
}