import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/common%20screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var profileImage;
  XFile? pickedFile;
  File? image;
  var Name = TextEditingController();
  var Email = TextEditingController();
  var Adress = TextEditingController();
  var District = TextEditingController(); // Added District controller
  var Pin = TextEditingController();
  var password = TextEditingController();
  var confirmPass = TextEditingController();
  var State = TextEditingController();
  var Mobile = TextEditingController();
  String gender = "";
  final fkey = GlobalKey<FormState>();
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Registration')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(key: fkey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
              
                      setState(() {
                        if (pickedFile != null) {
                          profileImage = File(pickedFile!.path);
                        }
                      });
                    },
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            profileImage != null ? FileImage(profileImage) : null,
                        child: profileImage == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 30,
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: Name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: Email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      // You can add email format validation here if needed
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Gender:'),
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: Adress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter House name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'House name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: District,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter District';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'District',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: Pin,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Pin No';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Pin No',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: State,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter State';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: Mobile,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Mobile Number';
                      }
                      // You can add mobile number format validation here if needed
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      // You can add more password validation here if needed
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: confirmPass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Confirm Password';
                      }
                      if (value != password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await uploadImage();
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: Email.text,
                          password: password.text,
                        );
              
                        await FirebaseFirestore.instance
                            .collection('User_Registration')
                            .add({
                          'name': Name.text,
                          'email': Email.text,
                          'conform password':confirmPass.text,
                          'Adress': Adress.text,
                          'District': District.text,
                          'pin': Pin.text,
                          'mobile no': Mobile.text,
                          'password': password.text,
                          'gender': gender,
                          'state': State.text,
                          'image_url': imageUrl,
                        });
              
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(
                              type: "user",
                            ),
                          ),
                        );
                      } catch (e) {
                        print('Error creating user: $e');
                      }
                    },
                    child: Text('REGISTER'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    try {
      if (profileImage != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('image/${DateTime.now()}.jpg');

        await storageReference.putFile(profileImage!);

        imageUrl = await storageReference.getDownloadURL();
        print('Image URL: $imageUrl');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
