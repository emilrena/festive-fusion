// import 'package:festive_fusion/USER/user_functions.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Designers/DesignerNavigationBar.dart';
import 'package:festive_fusion/Makeup/MakupNav.dart';
import 'package:festive_fusion/Rental/RentalNav.dart';
import 'package:festive_fusion/mehandi/MehandiNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Mehandi_EditProfile extends StatefulWidget {
  const  Mehandi_EditProfile({super.key});

  @override
  State<Mehandi_EditProfile> createState() => _Mehandi_EditProfileState();
}

class _Mehandi_EditProfileState extends State<Mehandi_EditProfile> {
  var profileImage;
  XFile? pickedFile;
  File? image;
  var Name = TextEditingController();
  var Email = TextEditingController();
  var Adress = TextEditingController();
  var District = TextEditingController();
  var Pin= TextEditingController();
  var password = TextEditingController();
  var confirmPass = TextEditingController();
   var State = TextEditingController();
    var Mobile = TextEditingController();
  String gender = "";
  String selectedExperience = '0-1 years';
   final fkey = GlobalKey<FormState>();

  // List of years of experience options
  List<String> experienceOptions = [
    '0-1 years',
    '1-2 years',
    '2-3 years',
    '3-5 years',
    '5+ years',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(' Mehandi_EditProfile')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(key: fkey,
                child: Container(
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              ImagePicker picker = ImagePicker();
                              pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                
                              setState(() {
                                if (pickedFile != null) {
                                  profileImage = File(pickedFile!.path);
                                }
                              });
                            },
                            child: ClipOval(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage)
                                    : null,
                                child: profileImage == null
                                    ? Icon(
                                        Icons.camera_alt,
                                        size: 30,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Name'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: Name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Email'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: Email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Gender'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text('Male'),
                            Radio(
                              value: 'Female',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            Text('Female'),
                          ],
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('House name'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: Adress,
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('state'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: State,
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('District'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: District,
                          
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Pin No'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: Pin,
                           validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Mobile Number'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: Mobile,
                           validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Password'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: password,
                           validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('confirm password'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: confirmPass,
                           validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 224, 206, 221),
                              filled: true,
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none)),
                        ),
                
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Year of Experience'),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedExperience,
                          onChanged: (String? value) {
                            setState(() {
                              selectedExperience = value!;
                            });
                          },
                          items: List.generate(
                            experienceOptions.length,
                            (index) => DropdownMenuItem(
                              value: experienceOptions[index],
                              child: Text(experienceOptions[index]),
                            ),
                          ),
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        // ... (remaining code)
                
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Mehandi edit profile')
                                .add({
                              'name': Name.text,
                              'email': Email.text,
                              'Adress': Adress.text,
                              'state': State.text,
                              'District': District.text,
                              'pin': Pin.text,
                              'mobile no': Mobile.text,
                              'password': password.text,
                              'conform password': confirmPass.text,
                              'gender': gender,
                              'experience': selectedExperience,
                              // 'image_url': profileImage,
                            });
                            print(Name.text);
                              print(Email.text);
                              print(Adress.text);
                              print(State.text);
                              print(District.text);
                              print(Pin.text);
                              print(Mobile.text);
                              print(password.text);
                              print(confirmPass.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MehandiNav();
                            }));
                          },
                          child: Text('register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
