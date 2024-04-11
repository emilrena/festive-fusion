import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:festive_fusion/Designers/upload_image.dart';
import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/packageview.dart';

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
  late String _selectedCategory = 'Bridal Dress'; // Default to Bridal Dress
  late String _selectedDressCategory = 'Haldi'; // Default to Haldi

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

  var sp;
  var img;
  var id;

  Future<void> _loadImages() async {
  SharedPreferences spr = await SharedPreferences.getInstance();
  setState(() {
    sp = spr.get('name');
    img = spr.get('image_url');
    id = spr.getString('uid');
  });
  setState(() {
    _isLoading = true;
  });

  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('designer_upload_image')
        .where('designer_id', isEqualTo: id)
        .where('category', isEqualTo: _selectedCategory)
        .where('dress', isEqualTo: _selectedDressCategory)
        .get();

    print(snapshot.docs.length); // This prints the number of documents returned by the query
    setState(() {
      _imageUrls =
          snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
      print(_imageUrls); // This prints the list of image URLs fetched from Firestore
    });
  } catch (error) {
    print('Error loading images: $error'); // This prints any error that occurs during the fetching process
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
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _getImage,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Select Category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Bridal Dress'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Bridal Dress';
                });
                _showDressCategoryOptionsDialog(context);
              },
            ),
            ListTile(
              title: Text('Groom Dress'),
              onTap: () {
                setState(() {
                  _selectedCategory = 'Groom Dress';
                });
                _showDressCategoryOptionsDialog(context);
              },
            ),
          ],
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
                        backgroundImage: img != null ? NetworkImage(img) : null,
                        radius: 35,
                        backgroundColor: Colors.grey, 
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(sp),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DesignerMessage();
                      }));
                    },
                    child: Text(
                      '   ENQUIRY   ',
                      style:
                          TextStyle(color: Color.fromARGB(221, 126, 10, 106)),
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

  Future<void> _showDressCategoryOptionsDialog(BuildContext context) async {
    String? selectedDressCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Dress Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('haldi'),
                onTap: () {
                  Navigator.pop(context, 'haldi');
                },
              ),
              ListTile(
                title: Text('mehandi'),
                onTap: () {
                  Navigator.pop(context, 'mehandi');
                },
              ),
              ListTile(
                title: Text('reception'),
                onTap: () {
                  Navigator.pop(context, 'reception');
                },
              ),
              ListTile(
                title: Text('wedding'),
                onTap: () {
                  Navigator.pop(context, 'wedding');
                },
              ),
              // Add more options as needed
            ],
          ),
        );
      },
    );

    if (selectedDressCategory != null) {
      setState(() {
        _selectedDressCategory = selectedDressCategory;
        _loadImages();
     
      });
    }
  }
}
