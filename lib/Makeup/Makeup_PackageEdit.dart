// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:festive_fusion/Makeup/Makeup_packageView.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class Makeup_Package_Edit extends StatefulWidget {
//   const Makeup_Package_Edit({super.key});

//   @override
//   State<Makeup_Package_Edit> createState() => _Makeup_Package_EditState();
// }

// class _Makeup_Package_EditState extends State<Makeup_Package_Edit> {
//   var packageEdit = TextEditingController();
//   var DescriptionEdit = TextEditingController();
//    final fkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('EDIT')),
//       ),
//       body: Form(key: fkey,
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('Assets/makeup.webp'), fit: BoxFit.cover),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 28, right: 28),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextFormField(controller: packageEdit,
//                   validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'field is empty';
//                           }
//                           return null;
//                         },
//                     decoration: InputDecoration(
//                         hintText: 'service',
//                         fillColor: Color.fromARGB(255, 182, 174, 196),
//                         filled: true,
//                         border:
//                             UnderlineInputBorder(borderSide: BorderSide.none)),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   SingleChildScrollView(
//                     child: TextFormField(controller: DescriptionEdit,
//                     validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'field is empty';
//                           }
//                           return null;
//                         },
//                       maxLines: 5,
//                       decoration: InputDecoration(
//                           hintText: 'Describe here',
//                           fillColor: Color.fromARGB(255, 182, 174, 196),
//                           filled: true,
//                           border:
//                               UnderlineInputBorder(borderSide: BorderSide.none)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () 
//                             async {
//                             await FirebaseFirestore.instance
//                                 .collection('makeup_package')
//                                 .add({
//                               'package': packageEdit.text,
//                               'description': DescriptionEdit.text,
                              
                              
//                             });
//                               if (fkey.currentState!.validate()) {
//                             print(packageEdit.text);
//                             print(DescriptionEdit.text);
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return Makeup_Package_View();
//                             }));
//                           }},
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   const Color.fromARGB(255, 206, 197, 221))),
//                           child: Text(
//                             'OK',
//                             style: TextStyle(color: Colors.black87),
//                           )),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
