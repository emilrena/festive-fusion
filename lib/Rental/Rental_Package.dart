import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Rental_Package_Add extends StatefulWidget {
  const Rental_Package_Add({super.key});

  @override
  State<Rental_Package_Add> createState() => _Rental_Package_AddState();
}

class _Rental_Package_AddState extends State<Rental_Package_Add> {
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
              image: AssetImage('Assets/rental.jpg'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(controller: package,
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
                                .collection('makeup_package')
                                .add({
                              'package': package.text,
                              'description':Description.text,
                              
                              
                              
                            });
                          print(package.text);
                          print(Description.text);
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
