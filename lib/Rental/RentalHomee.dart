import 'package:festive_fusion/Rental/Rental_Message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Rental_UploadImage.dart'; 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentHome extends StatefulWidget {
  RentHome({Key? key});

  @override
  State<RentHome> createState() => _RentHomeState();
}

class _RentHomeState extends State<RentHome> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _userId;
  String? _userName;
  dynamic _userImageUrl; // Updated declaration

  List<String> _imageUrls = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadImages();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('uid');
      _userName = prefs.getString('name');
      // Load user image URL from shared preferences
      String? imageUrl = prefs.getString('image_url');
      // Set the image URL as the background image for CircleAvatar
      _userImageUrl = imageUrl != null ? NetworkImage(imageUrl) : AssetImage('Assets/p4.jpg');
    });
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      if (_image != null && await _image!.exists()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Rental_Upload_pic(imageFile: _image!),
          ),
        );
      } else {
        print('Image file does not exist or is invalid.');
      }
    } else {
      print('No image picked.');
    }
  }

  void _navigateToRentalMessagePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Rental_Message(),
      ),
    );
  }

  Future<void> _loadImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('rental_upload_image')
          .where('rental_id', isEqualTo: _userId)
          .get();

      setState(() {
        _imageUrls =
            snapshot.docs.map((doc) => doc['image_url'] as String).toList();
      });
    } catch (error) {
      print('Error loading images: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userId == null) {
      // If _userId is not initialized yet, return a loading indicator or an empty container
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'HOME',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // Once _userId is initialized, build the UI
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'HOME',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: _userImageUrl, // Use the user's image URL here
                          radius: 35,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _userName ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _getImage,
                    child: Text('Upload Image'),
                  ),
                  ElevatedButton(
                    onPressed: _navigateToRentalMessagePage,
                    child: Text('Enquiry'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _imageUrls.isEmpty
                        ? Center(child: Text('No images available'))
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: _imageUrls.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                _imageUrls[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
