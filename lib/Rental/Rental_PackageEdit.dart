import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Rental/Rental_PackageView.dart';
import 'package:flutter/material.dart';

class Rental_Package_edit extends StatefulWidget {
  const Rental_Package_edit({super.key});

  @override
  State<Rental_Package_edit> createState() => _Rental_Package_editState();
}

class _Rental_Package_editState extends State<Rental_Package_edit> {
  var packageEdit=TextEditingController();
  var DescriptionEdit=TextEditingController();
  final fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Center(child: Text('EDIT')),
      ),
      body: Form(key: fkey,
        child: Container(
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/rental.jpg'),fit: BoxFit.cover),
                      ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 28,right: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  TextFormField(decoration: InputDecoration(hintText:'service',
                    fillColor: Color.fromARGB(255, 182, 174, 196),
                                          filled: true,
                                          border: UnderlineInputBorder(
                                            
                                            borderSide: BorderSide.none)
                                          
                                            
                                          ),
                  
                  ),SizedBox(height: 30,),
                  TextFormField(maxLines: 5,
                    decoration: InputDecoration(hintText: 'Describe here',
                      fillColor: Color.fromARGB(255, 182, 174, 196),
                                          filled: true,
                                          border: UnderlineInputBorder(
                                            
                                            borderSide: BorderSide.none)
                                          
                                            
                                          ),
                  
                  ),
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: ()async {
                            await FirebaseFirestore.instance
                                .collection(' Rental package edit ')
                                .add({
                              'package': packageEdit.text,
                              'description': DescriptionEdit.text,
                              
                              
                            });
                             if (fkey.currentState!.validate()) {
                            print(packageEdit.text);
                            print(DescriptionEdit);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Rental_Package_view();
                              },
                            ));
                             }
                        
                      }, 
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 206, 197, 221))),
                      child: Text('OK',style: TextStyle(color: Colors.black87),)),
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