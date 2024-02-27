import 'dart:developer';

import 'package:festive_fusion/ADMIN/AdminHome.dart';
import 'package:festive_fusion/ADMIN/AdminMehandiView.dart';
import 'package:festive_fusion/Designers/DesignerEditProfile.dart';
import 'package:festive_fusion/Designers/Designer_registration.dart';
import 'package:festive_fusion/Designers/EditService.dart';
import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/packageAdd.dart';
import 'package:festive_fusion/Designers/packageview.dart';
// import 'package:festive_fusion/Designers/service.dart';
import 'package:festive_fusion/Designers/upload_image.dart';
import 'package:festive_fusion/Makeup/Makeup_PackageEdit.dart';
import 'package:festive_fusion/Makeup/Makeup_Upload_Image.dart';
import 'package:festive_fusion/Makeup/Makeup_editProfile.dart';
import 'package:festive_fusion/Makeup/Makeup_message.dart';
import 'package:festive_fusion/Makeup/Makeup_package.dart';
import 'package:festive_fusion/Makeup/Makeup_packageView.dart';
import 'package:festive_fusion/Makeup/Makeup_registration.dart';
import 'package:festive_fusion/Rental/Rental_EditProfile.dart';
import 'package:festive_fusion/Rental/Rental_Message.dart';
import 'package:festive_fusion/Rental/Rental_Package.dart';
import 'package:festive_fusion/Rental/Rental_PackageEdit.dart';
import 'package:festive_fusion/Rental/Rental_PackageView.dart';
import 'package:festive_fusion/Rental/Rental_Registration.dart';
import 'package:festive_fusion/Rental/Rental_UploadImage.dart';
import 'package:festive_fusion/USER/DesignerProffesinalsView.dart';
import 'package:festive_fusion/USER/MakeupProffesionals.dart';
import 'package:festive_fusion/USER/MehandiProffesionalsView.dart';
import 'package:festive_fusion/USER/RentalProffesionals.dart';
import 'package:festive_fusion/USER/UserHome.dart';
import 'package:festive_fusion/USER/UserPayment.dart';
// import 'package:festive_fusion/USER/User_Edit_Profile.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:festive_fusion/USER/edit_profile.dart';
import 'package:festive_fusion/USER/enquiery.dart';
import 'package:festive_fusion/USER/package.dart';
import 'package:festive_fusion/demolist.dart';
import 'package:festive_fusion/mehandi/Mehandi_PackageView.dart';
import 'package:festive_fusion/mehandi/Mehandi_Upload_image.dart';
import 'package:festive_fusion/mehandi/Mehandi_editProfile.dart';
import 'package:festive_fusion/mehandi/Mehandi_message.dart';
import 'package:festive_fusion/mehandi/Mehandi_package.dart';
import 'package:festive_fusion/mehandi/Mehandi_packageEdit.dart';
import 'package:festive_fusion/mehandi/Mehandi_registration.dart';
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
        child: SingleChildScrollView(
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
                    return UserPckg();
                  }));
                }, child: Text('Packages'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return UsPayment();
                  }));
                }, child: Text('payment'),),
              ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Edit();
                  }));
                }, child: Text('Edit profile'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return RentalProffesional_View();
                  }));
                }, child: Text('MEHANDI PROFESSIONALS'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return DesignerProffesional_View();
                  }));
                }, child: Text('DESIGNER PROFESSIONALS'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return RentalProffesional_View();
                  }));
                }, child: Text('RENTAL PROFESSIONALS'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return UserHome();
                  }));
                }, child: Text('USER HOME'),),

                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return MakeupProffesional_View();
                  }));
                }, child: Text('MAKEUP PROFESSIONALS'),),

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
                    return package_add();
                  }));
                }, child: Text('PACKAGE Add'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return EditServices_();
                  }));
                }, child: Text('package Edit'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Vservice();
                  }));
                }, child: Text('package view'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Desgn_Reg();
                  }));
                }, child: Text('DESIGNER REGISTRATION'),),
          
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Upload_pic_describe();
                  }));
                }, child: Text('UPLOAD PIC AND DESCRIBE'),),
                SizedBox(height: 20,),
                Text('mehandi'),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehandi_Reg();
                  }));
                }, child: Text('mehandi reg'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehandi_Message();
                  }));
                }, child: Text('mehandi message'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehandi_EditProfile();
                  }));
                }, child: Text('mehandi edit profile'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehndi_package_add();
                  }));
                }, child: Text('mehandi package add'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehndi_package_edit();
                  }));
                }, child: Text('mehandi package edit'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehndi_package_view();
                  }));
                }, child: Text('mehandi package view'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Mehndi_Upload_pic();
                  }));
                }, child: Text('mehandi upload image'),),
                SizedBox(height: 20,),
                Text('MAKEUP MODULE'),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Registration();
                  }));
                }, child: Text('MAKEUP Restration'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_EditProfile();
                  }));
                }, child: Text('MAKEUP EDIT PROFILE'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Message();
                  }));
                }, child: Text('MAKEUP message'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Package_Add();
                  }));
                }, child: Text('MAKEUP PACKAGE'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Package_Edit();
                  }));
                }, child: Text('MAKEUP PACKAGE EDIT'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Package_View();
                  }));
                }, child: Text('MAKEUP PACKAGE view'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Upload_pic();
                  }));
                }, child: Text('MAKEUP UPLOAD IMAGE'),),
                  SizedBox(height: 20,),
                Text('RENTAL MODULE'),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Registration();
                  }));
                }, child: Text('Rental Registration'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Edit_Profile();
                  }));
                }, child: Text('Rental edit profile'),), 
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Message();
                  }));
                }, child: Text('Rental message'),), 
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Package_Add();
                  }));
                }, child: Text('Rental Package add'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Package_edit();
                  }));
                }, child: Text('Rental package edit'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Package_view();
                  }));
                }, child: Text('Rental package view'),),
                ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Rental_Upload_pic(); 
                  }));
                }, child: Text('Rental upload image'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return MyWidget(); 
                  }));
                }, child: Text('List'),),
                 Text('ADMIN MODULE'),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return AdminHome();
                  }));
                }, child: Text('ADMIN HOME'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return AdminMehandiView();
                  }));
                }, child: Text('ADMIN MEHANDI ARTIST VIEW'),),
                 ElevatedButton
                (onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return AdminMehandiView();
                  }));
                }, child: Text('ADMIN MAKEUP ARTIST VIEW'),),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}