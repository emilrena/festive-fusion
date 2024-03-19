// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:festive_fusion/Designers/DesignerHome.dart';
// import 'package:festive_fusion/Designers/packageview.dart';
// import 'package:flutter/material.dart';

// class EditServices_ extends StatefulWidget {
//   final String packageData;

//   const EditServices_({Key? key, required this.packageData}) : super(key: key);

//   @override
//   State<EditServices_> createState() => _EditServices_State();
// }

// class _EditServices_State extends State<EditServices_> {
//   TextEditingController packageEdit = TextEditingController();
//   TextEditingController descriptionEdit = TextEditingController();
//   final GlobalKey<FormState> fkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     // packageEdit.text = widget.packageData['package'] ?? '';
//     // descriptionEdit.text = widget.packageData['description'] ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('EDIT'),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: fkey,
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('Assets/image1.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 28.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   controller: packageEdit,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Field is empty';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Service',
//                     fillColor: Color.fromARGB(255, 182, 174, 196),
//                     filled: true,
//                     border: UnderlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextFormField(
//                   controller: descriptionEdit,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Field is empty';
//                     }
//                     return null;
//                   },
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     hintText: 'Describe here',
//                     fillColor: Color.fromARGB(255, 182, 174, 196),
//                     filled: true,
//                     border: UnderlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (fkey.currentState!.validate()) {
//                           await FirebaseFirestore.instance
//                               .collection('designerPackages')
//                               // .doc(widget.packageData['docId'])s
//                               .update({
//                             'package': packageEdit.text,
//                             'description': descriptionEdit.text,
//                           });
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => Vservice()),
//                           );
//                         }
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           const Color.fromARGB(255, 206, 197, 221),
//                         ),
//                       ),
//                       child: Text(
//                         'OK',
//                         style: TextStyle(color: Colors.black87),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
