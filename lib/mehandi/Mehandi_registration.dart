// import 'package:festive_fusion/USER/user_functions.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:festive_fusion/common%20screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Mehandi_Reg extends StatefulWidget {
  const Mehandi_Reg({super.key});

  @override
  State<Mehandi_Reg> createState() => _Mehandi_RegState();
}

class _Mehandi_RegState extends State<Mehandi_Reg> {
  var profileImage;
  XFile? pickedFile;
  File? image;
  var Name = TextEditingController();
  var Email = TextEditingController();
  var Adress = TextEditingController();
  var District = TextEditingController();
  var Pin = TextEditingController();
  var password = TextEditingController();
  var confirmPass = TextEditingController();
  var State = TextEditingController();
  var Mobile = TextEditingController();
  String gender = "";
  String selectedExperience = '0-1 years';
  final fkey = GlobalKey<FormState>();
  String imageUrl = '';
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
        title: Center(child: Text('Mehandi_Reg')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: fkey,
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
                            if (value!.isEmpty) {
                              return 'enter Name';
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
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
                            if (value!.isEmpty) {
                              return 'enter email';
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 206, 221),
                            filled: true,
                            border: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
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
                              child: Text('state'),
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
                          },
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
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
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
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
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
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
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
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
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
                            if (value!.isEmpty) {
                              return 'field is empty';
                            }
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
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
                            // Perform image upload
                            await uploadImage();

                            // Register user in Firebase Authentication
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: Email.text,
                                password: password.text,
                              );

                              // If user creation is successful, proceed to store user data in Firestore
                              await FirebaseFirestore.instance
                                  .collection('Mehandi register')
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
                                'image_url': imageUrl,
                                'status':0,
                                       
                                // Optionally, store additional mehandi data
                              });

                              // Navigate to next screen upon successful registration
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Login(type: 'mehandi',);
                                },
                              ));
                            } catch (e) {
                              print('Error creating mehandi: $e');
                              // Handle any errors that occur during mehandi creation
                            }
                          },
                          child: Text('REGISTER'),
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

  Future<void> uploadImage() async {
    try {
      if (profileImage != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('image/${pickedFile!.name}');

        await storageReference.putFile(profileImage!);

        // Get the download URL
        imageUrl = await storageReference.getDownloadURL();

        // Now you can use imageUrl as needed (e.g., save it to Firestore)
        print('Image URL: $imageUrl');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
