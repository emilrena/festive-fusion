import 'dart:io';
import 'package:festive_fusion/Rental/RentalHomee.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
 

class Rental_Upload_pic extends StatefulWidget {
  final File imageFile;

  const Rental_Upload_pic({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<Rental_Upload_pic> createState() => _Rental_Upload_picState();
}

class _Rental_Upload_picState extends State<Rental_Upload_pic> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _rateController = TextEditingController(); // Added rate controller

  List<String> _categories = [
    'Jewellery',
    'Gown',
    'Lehenga',
    'Shirt',
    'Sharara',
    'Dupatta',
    'Coat',
  ];

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECTED'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'ENTER THE DETAILS:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(widget.imageFile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Describe here',
                  fillColor: Color.fromARGB(255, 182, 174, 196),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text('Select Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Rate',
                  fillColor: Color.fromARGB(255, 182, 174, 196),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String description = _descriptionController.text;
                String category = _selectedCategory ?? '';
                double rate = double.tryParse(_rateController.text) ?? 0.0;

                SharedPreferences sp = await SharedPreferences.getInstance();
                var a = sp.getString('uid');
                
                try {
                  if (a != null) {
                    String imageUrl = await uploadImage();
                    await FirebaseFirestore.instance.collection('rental_upload_image').add({
                      'description': description,
                      'category': category,
                      'rate': rate,
                      'image_url': imageUrl,
                      'user_id': a, // Adding user_id
                    });
                    print('Data uploaded successfully');
                  } else {
                    print('User ID not found');
                  }
                } catch (error) {
                  print('Error uploading data: $error');
                }

                // Navigate to the rental home page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RentHome()),
                );
              },
              child: Text('UPLOAD'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(widget.imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (error) {
      throw Exception('Error uploading image: $error');
    }
  }
}
