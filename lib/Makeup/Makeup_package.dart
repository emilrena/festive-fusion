import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Makeup/MakupNav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Makeup_Package_Add extends StatefulWidget {
  const Makeup_Package_Add({super.key});

  @override
  State<Makeup_Package_Add> createState() => _Makeup_Package_AddState();
}

class _Makeup_Package_AddState extends State<Makeup_Package_Add> {
  var package = TextEditingController();
  var Description = TextEditingController();
   final fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Form(key: fkey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/makeup.webp'), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(controller: package,
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
                  TextFormField(controller: Description,
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
                          onPressed: () async {
                             SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        var a = sp.getString('uid');
                            await FirebaseFirestore.instance
                                .collection('makeup_package')
                                .add({
                              'package': package.text,
                              'description':Description.text,
                              'package_id':a,
                              
                              
                              
                            });
                            if (fkey.currentState!.validate()) {
                            print(package.text);
                            print(Description.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MakeupNav();
                            }));
                          }},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 206, 197, 221))),
                          child: Text(
                            'SUBMIT',
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
