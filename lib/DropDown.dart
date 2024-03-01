// import 'dart:html';

// import 'package:flutter/material.dart';

// class DropDemo extends StatefulWidget {
//   const DropDemo({super.key});

//   @override
//   State<DropDemo> createState() => _DropDemoState();
// }

// class _DropDemoState extends State<DropDemo> {
//   String dropdownvalue='item1';
//   var district=[
//     'item 1',
//     'item 2',
//     'item 3',
//     'item 4',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Column(
//         children: [
//           DropdownButton(
//             value: dropdownvalue,
//             icon: const Icon(Icons.keyboard_double_arrow_down_sharp),
//             items: district.map((String item1) {
//               return DropdownMenuItem(
//                 value: item1,
//                 child: Text('item1'));
            
//             );
  
//           ),
//   }).toK


//         ],
//       ) ,
//     );
//   }
// }