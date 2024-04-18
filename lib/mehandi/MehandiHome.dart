import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/packageview.dart';
import 'package:festive_fusion/Designers/upload_image.dart';
import 'package:festive_fusion/Makeup/Makeup_Upload_Image.dart';
import 'package:festive_fusion/Makeup/Makeup_message.dart';
import 'package:festive_fusion/Makeup/Makeup_packageView.dart';
import 'package:festive_fusion/mehandi/Mehandi_PackageView.dart';
import 'package:festive_fusion/mehandi/Mehandi_Upload_image.dart';
import 'package:festive_fusion/mehandi/Mehandi_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MehandiHome extends StatefulWidget {
  const MehandiHome({Key? key}) : super(key: key);

  @override
  State<MehandiHome> createState() => _MehandiHomeState();
}

class _MehandiHomeState extends State<MehandiHome> {
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
          builder: (context) =>Mehndi_Upload_pic(imageFile: _image),
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
      print(id);
      print(img);
    });
    setState(() {
      _isLoading = true;
    });

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('mehandi_upload_image')
          .where('mehandi_id', isEqualTo: id)
          .get();

      print(snapshot.docs.length);
      setState(() {
        _imageUrls =
            snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
        print(_imageUrls);
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
                        backgroundImage: img != null ? NetworkImage(img) : null,
                        radius: 35,
                        backgroundColor: Colors
                            .grey, 
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
                        return Mehndi_package_view();
                      }));
                    },
                    child: Text(
                      '  DESIGNES  ',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.6),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 40),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) {
                //         return Mehandi_Message();
                //       }));
                //     },
                //     child: Text(
                //       '   ENQUIRY   ',
                //       style:
                //           TextStyle(color: Color.fromARGB(221, 126, 10, 106)),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(6.6),
                //       ),
                //     ),
                //   ),
                // ),
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
