import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Makeup_EditProfile extends StatefulWidget {
  const Makeup_EditProfile({Key? key}) : super(key: key);

  @override
  State<Makeup_EditProfile> createState() => _Makeup_EditProfileState();
}

class _Makeup_EditProfileState extends State<Makeup_EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String>? _userData;
  File? _profileImage;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? '';
    print('UID: $uid');

    // Fetch user data from Firestore
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('Makeup register')
            .doc(uid)
            .get();
    if (userSnapshot.exists) {
      setState(() {
        _userData = Map<String, String>.from(userSnapshot.data() ?? {});
        _imageUrl = _userData!['image_url'];
      });
    } else {
      print('User data not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('EditProfile')),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_userData != null) ...[
                  GestureDetector(
                    onTap: () {
                      _selectImageForDialog();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : _imageUrl != null
                              ? NetworkImage(_imageUrl!)
                              : AssetImage(
                                  'assets/placeholder_image.jpg') as ImageProvider<Object>?,
                      child: _profileImage == null &&
                              (_userData == null || _userData!['image_url'] == null)
                          ? Icon(Icons.camera_alt, size: 30)
                          : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  ..._buildUserDataFields(),
                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog();
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  List<Widget> _buildUserDataFields() {
    List<String> order = [
      'name',
      'Address',
      'email',
      'pin',
      'gender',
      'mobile',
      'experience',
      'District',
      'state',
    ];

    List<Widget> fields = [];
    order.forEach((key) {
      if (_userData != null && _userData!.containsKey(key)) {
        fields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  key,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 4),
                TextFormField(
                  initialValue: _userData![key],
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
    return fields;
  }

  Future<void> _showEditDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectImageForDialog();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : _imageUrl != null
                              ? NetworkImage(_imageUrl!)
                              : AssetImage(
                                  'assets/placeholder_image.jpg') as ImageProvider<Object>?,
                      child: _profileImage == null &&
                              (_userData == null || _userData!['image_url'] == null)
                          ? Icon(Icons.camera_alt, size: 30)
                          : null,
                    ),
                  ),
                  TextFormField(
                    initialValue: _userData?['name'],
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      _userData?['name'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['Address'],
                    decoration: InputDecoration(labelText: 'Address'),
                    onChanged: (value) {
                      _userData!['Address'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (value) {
                      _userData!['email'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['pin'],
                    decoration: InputDecoration(labelText: 'Pin'),
                    onChanged: (value) {
                      _userData!['pin'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['gender'],
                    decoration: InputDecoration(labelText: 'Gender'),
                    onChanged: (value) {
                      _userData!['gender'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['mobile'],
                    decoration: InputDecoration(labelText: 'Mobile'),
                    onChanged: (value) {
                      _userData!['mobile'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['experience'],
                    decoration: InputDecoration(labelText: 'Experience'),
                    onChanged: (value) {
                      _userData!['experience'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['District'],
                    decoration: InputDecoration(labelText: 'District'),
                    onChanged: (value) {
                      _userData!['District'] = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData!['state'],
                    decoration: InputDecoration(labelText: 'State'),
                    onChanged: (value) {
                      _userData!['state'] = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveChanges();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveChanges() async {
    // Perform validation if needed
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid') ?? '';

      // Update data in Firestore
      if (_userData != null) {
        await FirebaseFirestore.instance
            .collection('Makeup register')
            .doc(uid)
            .update(_userData!);
      }

      // Upload profile image if it has been changed
      if (_profileImage != null) {
        await _uploadProfileImage(uid);
      }

      // Fetch updated data
      await _fetchUserData();

      // Close dialog and return to previous page
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectImageForDialog() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _imageUrl = null; // Reset imageUrl when a new image is selected
      });
    }
  }

  Future<void> _uploadProfileImage(String uid) async {
    if (_profileImage == null) return;

    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child('$uid.jpg');

      await storageReference.putFile(_profileImage!);

      String downloadURL = await storageReference.getDownloadURL();

      // Update user data in Firestore with the new image URL
      await FirebaseFirestore.instance
          .collection('Makeup register')
          .doc(uid)
          .update({'image_url': downloadURL});
    } catch (error) {
      print('Error uploading image: $error');
    }
  }
}
