import 'dart:developer';

import 'package:festive_fusion/Designers/DesignerEditProfile.dart';
import 'package:festive_fusion/Designers/EditService.dart';
import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/service.dart';
// import 'package:festive_fusion/USER/User_Edit_Profile.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/edit_profile.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:flutter/material.dart';

class Functions_user extends StatefulWidget {
  const Functions_user({super.key});

  @override
  State<Functions_user> createState() => _Functions_userState();
}

class _Functions_userState extends State<Functions_user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      
      SafeArea(
        child: Container(
          child: Column(
            children: [
              ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return Message();
                }));
              }, child: Text('enquiry'),),
           ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return Booked();
                }));
              }, child: Text('Booking'),),
            ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return Edit();
                }));
              }, child: Text('Edit profile'),),
              SizedBox(height: 20,),
              Text('Designer Module'),

              ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return DesignerMessage();
                }));
              }, child: Text('designer message'),),
               ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return DsgEdit();
                }));
              }, child: Text('designer profile edit'),),
            ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return Services_();
                }));
              }, child: Text('service add'),),
              ElevatedButton
              (onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return EditServices_();
                }));
              }, child: Text('service Edit'),),
            ],
          ),
        ),
      ),
    );
  }
}