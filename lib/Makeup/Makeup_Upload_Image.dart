import 'dart:io';

import 'package:festive_fusion/Makeup/MakeupHome.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Makeup_Upload_pic extends StatefulWidget {
  final File imageFile;
  Makeup_Upload_pic({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<Makeup_Upload_pic> createState() => _Makeup_Upload_picState();
}

class _Makeup_Upload_picState extends State<Makeup_Upload_pic> {
  var describe = TextEditingController();
  final fkey = GlobalKey<FormState>();
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECTED'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('ENTER THE DETAILS:'),
                  ),
                ],
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: describe,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field is empty';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Describe here',
                    fillColor: Color.fromARGB(255, 182, 174, 196),
                    filled: true,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
               
                onPressed: () async {
                  SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        var a = sp.getString('uid');

                  try {
                    await uploadImage();
                    await FirebaseFirestore.instance
                        .collection('designer_upload_image')
                        .add({'describe': describe.text, 'imageUrl': imageUrl,'makeup_id': a});

                    if (fkey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MakeupHome()),
                      );
                    }
                  } catch (error) {
                    print('Error: $error');
                    // Handle error here
                  }
                },
                child: Text('UPLOAD'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    try {
      if (widget.imageFile != null) {
        Reference storageReference =
            FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Upload the image
        await storageReference.putFile(widget.imageFile);

        // Get the download URL after the upload is complete
        imageUrl = await storageReference.getDownloadURL();

        // Print the image URL for debugging
        print('Image URL: $imageUrl');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
