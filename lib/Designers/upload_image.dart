import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Upload_pic_describe extends StatefulWidget {
  const Upload_pic_describe({super.key});

  @override
  State<Upload_pic_describe> createState() => _Upload_pic_describeState();
}

class _Upload_pic_describeState extends State<Upload_pic_describe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SELECTED'),),
      body: SingleChildScrollView(
        child: Column(
          children: [Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('ENTER THE DETAILS:'),
              ),
            ],
          ),
            Container(
              height:300,width: 300,
               decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/WRK1.jpg',))
                          ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: TextFormField(maxLines: 5,
                      decoration: InputDecoration(hintText: 'Describe here',
                      
                        fillColor: Color.fromARGB(255, 182, 174, 196),
                                            filled: true,
                                            
                                            border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                                              
                                              borderSide: BorderSide.none)
                                            
                                              
                                            ),
                    
                    ),
           ),
           SizedBox(height: 20,),
           ElevatedButton(onPressed: (){}, child: Text('UPLOAD'))
          ],
        ),
      ),

    );
  }
}