import 'package:festive_fusion/Designers/DesignerHome.dart';
import 'package:festive_fusion/Designers/packageview.dart';
import 'package:flutter/material.dart';

class EditServices_ extends StatefulWidget {
  const EditServices_({super.key});

  @override
  State<EditServices_> createState() => _EditServices_State();
}

class _EditServices_State extends State<EditServices_> {
  var packageEdit = TextEditingController();
  var DescriptionEdit = TextEditingController();
   final fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('EDIT')),
      ),
      body: Form(key: fkey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/image1.jpg'), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(controller: packageEdit,
                    validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'field is empty';
                          }
                          return null;
                        },
                    decoration: InputDecoration(
                        hintText: 'service',
                        fillColor: Color.fromARGB(255, 182, 174, 196),
                        filled: true,
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(controller: DescriptionEdit,
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
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                               if (fkey.currentState!.validate()) {
                            print(packageEdit.text);
                            print(DescriptionEdit.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Vservice();
                            }));}
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 206, 197, 221))),
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.black87),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
