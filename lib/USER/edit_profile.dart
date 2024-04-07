import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Navigationbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  XFile? pickedFile;
  var profileImage;
  final Name = TextEditingController();
  final Email = TextEditingController();
  final Adress = TextEditingController();
  final District = TextEditingController();
  final Pin = TextEditingController();
  final password = TextEditingController();
  final confirmPass = TextEditingController();
  final StateController = TextEditingController();
  final Mobile = TextEditingController();
  String gender = "";
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: fkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      setState(() {
                        if (pickedFile != null) {
                          profileImage = File(pickedFile!.path);
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          profileImage != null ? FileImage(profileImage!) : null,
                      child: profileImage == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 30,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Name'),
                  TextFormField(
                    controller: Name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Email'),
                  TextFormField(
                    controller: Email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Gender'),
                  RadioListTile(
                    title: Text('Male'),
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Female'),
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Others'),
                    value: 'Others',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Address'),
                  TextFormField(
                    controller: Adress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('State'),
                  TextFormField(
                    controller: StateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('District'),
                  TextFormField(
                    controller: District,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Pin No'),
                  TextFormField(
                    controller: Pin,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Mobile Number'),
                  TextFormField(
                    controller: Mobile,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Password'),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Confirm Password'),
                  TextFormField(
                    controller: confirmPass,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (fkey.currentState!.validate()) {
                        await uploadImage();
                        await FirebaseFirestore.instance
                            .collection('user edit profile')
                            .add({
                          'name': Name.text,
                          'email': Email.text,
                          'address': Adress.text,
                          'state': StateController.text,
                          'district': District.text,
                          'pin': Pin.text,
                          'mobile no': Mobile.text,
                          'password': password.text,
                          'confirm password': confirmPass.text,
                          'gender': gender,
                          'image_url': imageUrl,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Navigationbar()),
                        );
                      }
                    },
                    child: Text('OK'),
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
        final storageReference = FirebaseStorage.instance.ref().child('image/${pickedFile!.name}');
        final uploadTask = storageReference.putFile(profileImage!);
        await uploadTask.whenComplete(() async {
          imageUrl = await storageReference.getDownloadURL();
          print('Image URL: $imageUrl');
        });
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
