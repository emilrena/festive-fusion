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
  TextEditingController _rateController = TextEditingController();
  TextEditingController _countController = TextEditingController(); // Added count controller

  List<String> _categories = ['Jewellery', 'Bridal Dress', 'Groom Dress'];
  String? _selectedCategory;
  List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPLOAD RENTAL ITEM'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPLOAD IMAGE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(widget.imageFile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'DESCRIPTION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter description...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'CATEGORY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text('Select category...'),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  _items = _getItemsForCategory(value!);
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'ITEM',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              value: null,
              hint: Text('Select item...'),
              onChanged: (value) {},
              items: _items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'RATE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter rate...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'TOTAL AVAILABLE COUNT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter total count...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String description = _descriptionController.text;
                String category = _selectedCategory ?? '';
                double rate = double.tryParse(_rateController.text) ?? 0.0;
                int count = int.tryParse(_countController.text) ?? 0;

                SharedPreferences sp = await SharedPreferences.getInstance();
                var userId = sp.getString('uid');
                
                try {
                  if (userId != null) {
                    String imageUrl = await uploadImage();
                    await FirebaseFirestore.instance.collection('rental_items').add({
                      'description': description,
                      'category': category,
                      'item': _items,
                      'rate': rate,
                      'count': count,
                      'image_url': imageUrl,
                      'rental_id': userId,
                    });
                    print('Data uploaded successfully');
                    
                    // Navigate to the rental home page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RentHome()),
                    );
                  } else {
                    print('User ID not found');
                  }
                } catch (error) {
                  print('Error uploading data: $error');
                }
              },
              child: Text('UPLOAD'),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getItemsForCategory(String category) {
    switch (category) {
      case 'Jewellery':
        return ['Choker', 'Earring', 'Bangles'];
      case 'Bridal Dress':
        return ['Gown', 'Lehenga', 'Saree'];
      case 'Groom Dress':
        return ['Suit', 'Sherwani', 'Kurta'];
      default:
        return [];
    }
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
