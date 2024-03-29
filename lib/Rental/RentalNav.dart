import 'package:festive_fusion/ADMIN/AdminComplaintView.dart';
import 'package:festive_fusion/ADMIN/AdminDesignerView.dart';
import 'package:festive_fusion/ADMIN/AdminHome.dart';
import 'package:festive_fusion/Designers/DesignerEditProfile.dart';
import 'package:festive_fusion/Designers/DesignerHome.dart';
import 'package:festive_fusion/Designers/DesignerPeoplesBooked.dart';
import 'package:festive_fusion/Rental/RentalHome.dart';
import 'package:festive_fusion/Rental/RentalHomee.dart';
import 'package:festive_fusion/Rental/RentalNotification.dart';
import 'package:festive_fusion/Rental/Rental_EditProfile.dart';
import 'package:festive_fusion/USER/BookedPeoples.dart';
import 'package:festive_fusion/USER/UserHome.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/mehandi/MehandiHome.dart';
import 'package:festive_fusion/mehandi/Mehandi_editProfile.dart';
import 'package:festive_fusion/registration.dart';
import 'package:flutter/material.dart';

class RentalNav extends StatefulWidget {
  const RentalNav({super.key});

  @override
  State<RentalNav> createState() => _RentalNavState();
}

class _RentalNavState extends State<RentalNav> {
  int selectedindex=1;
   static  List<dynamic>option=[
    RentalNotification(),
     RentHome(),                                               
    Rental_Edit_Profile(),
    

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