import 'dart:io';

import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/packageadd.dart';
import 'package:festive_fusion/Designers/packageview.dart';
import 'package:festive_fusion/Designers/upload_image.dart';
import 'package:festive_fusion/Makeup/Makeup_Upload_Image.dart';
import 'package:festive_fusion/Makeup/Makeup_message.dart';
import 'package:festive_fusion/Makeup/Makeup_packageView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DesignerHome extends StatefulWidget {
  const DesignerHome({super.key});

  @override
  State<DesignerHome> createState() => _DesignerHomeState();
}

class _DesignerHomeState extends State<DesignerHome> {
 final ImagePicker _picker = ImagePicker();
  late File _image;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
       Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>Upload_pic_describe(imageFile: _image),
      ),
    );
  

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
              child: ResponsiveGridList(
                desiredItemWidth: 150,
                minSpacing: 10,
                children: List.generate(20, (index) => index + 1).map((i) {
                  return Container(
                    height: 150,
                    alignment: Alignment(0, 0),
                    color: Color.fromARGB(255, 165, 146, 159),
                    child: Text(i.toString()),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
