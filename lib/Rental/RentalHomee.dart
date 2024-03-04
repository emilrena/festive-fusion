import 'package:festive_fusion/Rental/Rental_Message.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RentHome extends StatefulWidget {
  RentHome({Key? key});

  @override
  State<RentHome> createState() => _RentHomeState();
}

class _RentHomeState extends State<RentHome> {
  String selectedCategory = "Category 1"; // Initial category
  XFile? pickedFile;
  File? image;

  Future<void> _getImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile!.path);
      }
    });
    print(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.add)],
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
            SizedBox(height: 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    items: [
                      DropdownMenuItem(
                        child: Text('Category 1'),
                        value: 'Category 1',
                      ),
                      DropdownMenuItem(
                        child: Text('Category 2'),
                        value: 'Category 2',
                      ),
                      // Add more categories as needed
                    ],
                    onChanged: (value) {
                      if (value == 'Category 1') {
                        _getImageFromGallery();
                      }
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Rental_Message();
                      }));
                    },
                    child: Text(
                      '   ENQUIRY   ',
                      style: TextStyle(
                        color: Color.fromARGB(221, 126, 10, 106),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.6)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ResponsiveGridList(
                desiredItemWidth: 150,
                minSpacing: 10,
                children: List.generate(20, (index) => index + 1).map((i) {
                  return Container(
                    height: 150,
                    alignment: Alignment(0, 0),
                    color: Color.fromARGB(255, 165, 146, 159),
                    child: image != null ? Image.file(image!) : Text(i.toString()),
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
