import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Navigationbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
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

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('User_Registration')
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

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _profileImage != null
            ? FileImage(_profileImage!)
            : _imageUrl != null
                ? NetworkImage(_imageUrl!)
                : AssetImage('assets/placeholder_image.jpg') as ImageProvider<Object>?,
        child: _profileImage == null &&
                (_userData == null || _userData!['image_url'] == null)
            ? Icon(Icons.camera_alt, size: 30)
            : null,
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString('uid') ?? '';

      if (_userData != null) {
        await FirebaseFirestore.instance
            .collection('User_Registration')
            .doc(uid)
            .update(_userData!);
      }

      if (_profileImage != null) {
        await _uploadProfileImage(uid);
      }

      await _fetchUserData();

      Navigator.of(context).pop();
    }
  }

  Future<void> _uploadProfileImage(String uid) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
      await storageReference.putFile(_profileImage!);
      String downloadURL = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('User_Registration')
          .doc(uid)
          .update({'image_url': downloadURL});
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: _showEditDialog,
      child: Text('Edit Profile'),
    );
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
                  TextFormField(
                    initialValue: _userData?['name'],
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      _userData?['name'] = value;
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
                  TextFormField(
                    initialValue: _userData!['Adress'],
                    decoration: InputDecoration(labelText: 'Address'),
                    onChanged: (value) {
                      _userData!['Adress'] = value;
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
                _buildProfileImage(),
                SizedBox(height: 20),
                if (_userData != null) ..._buildUserDataFields(),
                SizedBox(height: 20),
                _buildEditButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildUserDataFields() {
    List<String> order = [
      'name',
      'Adress',
      'email',
      'pin',
      'gender',
      'mobile',
      'District',
      'state',
    ];

    List<Widget> fields = [];
    order.forEach((key) {
      if (_userData!.containsKey(key)) {
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
}
