import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/packageview.dart';
import 'package:festive_fusion/Designers/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DesignerHome extends StatefulWidget {
  const DesignerHome({Key? key}) : super(key: key);

  @override
  State<DesignerHome> createState() => _DesignerHomeState();
}

class _DesignerHomeState extends State<DesignerHome> {
  final ImagePicker _picker = ImagePicker();
  late File _image;
  late List<String> _imageUrls;
  bool _isLoading = false;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Upload_pic_describe(imageFile: _image),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('designer_upload_image').get();
      setState(() {
        _imageUrls = snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _getImage,
          ),
        ],
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('Assets/p4.jpg'),
                        radius: 35,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('RENA FATHIMA'),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Vservice();
                      }));
                    },
                    child: Text(
                      '  PACKAGES  ',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.6),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DesignerMessage();
                      }));
                    },
                    child: Text(
                      '   ENQUIRY   ',
                      style: TextStyle(color: Color.fromARGB(221, 126, 10, 106)),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Adjust as needed
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
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
