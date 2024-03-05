// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vehicle_rental/pages/rental_company/company_home_page.dart';
// import 'package:vehicle_rental/pages/rental_company/company_register.dart';

// import '../services/services.dart';
// import 'customer/customer_home_page.dart';
// import 'customer/customer_registration_page.dart';

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});

//   final fkey = GlobalKey<FormState>();

//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

  

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: fkey,
//           child: SafeArea(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: (height / 3), bottom: 20, left: 20, right: 20),
//                   child: const Text(
//                     'Trundle',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 169, 200, 226),
//                         fontSize: 50,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 40, bottom: 20, left: 20, right: 20),
//                   child: TextFormField(
//                     controller: usernameController,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'enter username';
//                       }
//                     },
//                     decoration: InputDecoration(
//                       label: Text('username'),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 40, left: 20, right: 20),
//                   child: TextFormField(
//                     controller: passwordController,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'enter password';
//                       }
//                     },
//                     decoration: InputDecoration(
//                       label: Text('password'),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                     onLongPress: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (_) => CustomerHomePage(),
//                         ),
//                       );
//                     },
//                     onPressed: () {
//                       if (fkey.currentState!.validate()) {
//                         login(context);
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Text('Login'),
//                     )),
//                 Text('Or'),
//                 TextButton(
//                     onPressed: () {
//                       signUpDialog(context);
//                     },
//                     child: Text('create new account'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
