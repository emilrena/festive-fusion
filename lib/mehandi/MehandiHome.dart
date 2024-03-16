import 'dart:io';
import 'package:festive_fusion/mehandi/Mehandi_PackageView.dart';
import 'package:festive_fusion/mehandi/Mehandi_Upload_image.dart';
import 'package:festive_fusion/mehandi/Mehandi_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MehandiHome extends StatefulWidget {
  const MehandiHome({Key? key}) : super(key: key);

  @override
  State<MehandiHome> createState() => _MehandiHomeState();
}

class _MehandiHomeState extends State<MehandiHome> {
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
        builder: (context) => Mehndi_Upload_pic(imageFile: _image),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mehndi_package_view()),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mehandi_Message()),
                      );
                    },
                    child: Text(
                      '   ENQUIRY   ',
                      style: TextStyle(color: Color.fromARGB(221, 126, 10, 106)),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.6)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Color.fromARGB(255, 165, 146, 159),
                    child: Text((index + 1).toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
