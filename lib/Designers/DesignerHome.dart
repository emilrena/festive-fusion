import 'dart:io';

import 'package:festive_fusion/Designers/message.dart';
import 'package:festive_fusion/Designers/packageview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DesignerHome extends StatefulWidget {
  const DesignerHome({super.key});

  @override
  State<DesignerHome> createState() => _DesignerHomeState();
}

class _DesignerHomeState extends State<DesignerHome> {
  @override
   XFile? pickedFile;
  File? image;
  Future<void> pickImage() async {
    ImagePicker Picker = ImagePicker();
    pickedFile = await Picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile!.path);
    });
    print(image);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [InkWell(onTap: (){
          pickImage();

      },
        child: Icon(Icons.add))],
        title: Text('HOME',style: TextStyle(color: Colors.deepPurple),
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
                      CircleAvatar(backgroundImage: AssetImage('Assets/p4.jpg'),
                      radius: 35,  
                      ),
                    ],
                  ),Padding(
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
              child: ElevatedButton
              (onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Vservice();
                  }));
              }, child: Text('  PACKAGES  ',style: TextStyle(color: Colors.deepPurple),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.6),
                ),
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: ElevatedButton
              (onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context){
                    return DesignerMessage();
                  }));
              }, child: Text('   ENQUIRY   ',style: TextStyle(color: Color.fromARGB(221, 126, 10, 106)),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.6)
                ),
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
                    children: List.generate(20, (index)=> index+1).map((i) {
            return Container(
              height: 150,
              alignment: Alignment(0, 0),
              color: Color.fromARGB(255, 165, 146, 159),
              child: Text(i.toString()),
            );
                    }).toList()
                ),
          )
          ],
        ),
      ),
      
    );
  }
}