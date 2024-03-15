import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/mehandi/Mehandi_PackageView.dart';
import 'package:flutter/material.dart';

class Mehndi_package_add extends StatefulWidget {
  const Mehndi_package_add({super.key});

  @override
  State<Mehndi_package_add> createState() => _Mehndi_package_addState();
}

class _Mehndi_package_addState extends State<Mehndi_package_add> {
  var package = TextEditingController();
  var Description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('Assets/mehandi.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(controller: Description,
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
                            await FirebaseFirestore.instance
                                .collection('mehandi_package')
                                .add({
                              'package': package.text,
                              'description':Description.text,
                              
                              
                              
                            });
                          print(package.text);
                          print(Description.text);

                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Mehndi_package_view();
                            },
                          ));
                        },
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
    );
  }
}
