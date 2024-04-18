import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/ADMIN/AdminNavigationBar.dart';
import 'package:festive_fusion/Designers/DesignerForgot.dart';
import 'package:festive_fusion/Designers/DesignerNavigationBar.dart';
import 'package:festive_fusion/Designers/Designer_registration.dart';
import 'package:festive_fusion/Makeup/Makeup_registration.dart';
import 'package:festive_fusion/Makeup/MakupNav.dart';
import 'package:festive_fusion/Navigationbar.dart';
import 'package:festive_fusion/Rental/RentalForgot.dart';
import 'package:festive_fusion/Rental/RentalNav.dart';
import 'package:festive_fusion/Rental/Rental_Registration.dart';
import 'package:festive_fusion/USER/functions.dart';
import 'package:festive_fusion/Makeup/forgotpassword.dart';
import 'package:festive_fusion/mehandi/MehandiForgot.dart';
import 'package:festive_fusion/mehandi/MehandiNav.dart';
import 'package:festive_fusion/mehandi/Mehandi_registration.dart';
import 'package:festive_fusion/registration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  String type;
  Login({super.key, required this.type});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var Email = TextEditingController();
  var Pass = TextEditingController();
  final fkey = GlobalKey<FormState>();

  Future<void> gatData() async {
    print('object');
    // admin login
    if (widget.type == 'admin') {
      if (Email.text == 'admin@gmail.com' && Pass.text == 'admin123') {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return (AdminNav());
          },
        ));
      }
    }
    //mehandi login
    if (widget.type == 'mehandi') {
      print('Mehendi');
      final QuerySnapshot mechSnapshot = await FirebaseFirestore.instance
          .collection('Mehandi register')
          .where('email', isEqualTo: Email.text)
          .where('password', isEqualTo: Pass.text)
          // .where('status', isEqualTo: 1)
          .get();
      if (mechSnapshot.docs.isNotEmpty) {
        var userid = mechSnapshot.docs[0].id;
        var image_url = mechSnapshot.docs[0]['image_url'];
        var username = mechSnapshot.docs[0]['name'];
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('uid', userid);
        sp.setString('name', username);
        sp.setString('image_url', image_url);

        if (mechSnapshot.docs.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Login Successful ');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MehandiNav();
          }));
        }
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    //user login

    if (widget.type == 'user') {
      print('user');
      final QuerySnapshot usershot = await FirebaseFirestore.instance
          .collection('User_Registration')
          .where('email', isEqualTo: Email.text)
          .where('password', isEqualTo: Pass.text)
          // .where('status', isEqualTo: 1)
          .get();

      if (usershot.docs.isNotEmpty) {
        var userid = usershot.docs[0].id;
        var useradress = usershot.docs[0]['Adress'];
        var username = usershot.docs[0]['name'];
        var userDistrict = usershot.docs[0]['District'];
        var userState = usershot.docs[0]['state'];
        var userpin = usershot.docs[0]['pin'];
        var image_url = usershot.docs[0]['image_url'];
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('uid', userid);
        sp.setString('adress', useradress);
        sp.setString('name', username);
        sp.setString('district', userDistrict);
        sp.setString('state', userState);
        sp.setString('pin', userpin);
        sp.setString('image_url', image_url);

        if (usershot.docs.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Login Successful ');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Navigationbar();
          }));
        }
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    // makeup login
   // makeup login
// makeup login
if (widget.type == 'makeup') {
  print('__________makeup');
  final QuerySnapshot makeupshot = await FirebaseFirestore.instance
      .collection('Makeup register')
      .where('email', isEqualTo: Email.text)
      .where('password', isEqualTo: Pass.text)
      .where('status', isEqualTo: 0)
      .get();

  if (makeupshot.docs.isNotEmpty) {
    final makeupData = makeupshot.docs.first.data() as Map<String, dynamic>;
    final status = makeupData['status'];
    
    if (status == 1) {
      // If status is 1, the makeup artist is blocked
      print('Makeup artist is blocked. Cannot login.');
      // Show a dialog indicating that the account is blocked
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Blocked by Admin'),
          content: Text('Your account has been blocked by the admin.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // If status is 0, the makeup artist is not blocked
      print('Makeup artist is not blocked. Proceed with login.');
      
      var userid = makeupshot.docs[0].id;
      var image_url = makeupData['image_url'];
      var username = makeupData['name'];
      print('userid:_____$userid');
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('uid', userid);
      sp.setString('name', username);
      sp.setString('image_url', image_url);

      Fluttertoast.showToast(msg: 'Login Successful ');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MakeupNav();
      }));
    }
  } else {
    // If no document matches the query, the user credentials are invalid
    print('Invalid email or password.');
    // Show a message to the user indicating invalid credentials
    // You can use a snackbar, dialog, or any other UI element to display the message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text('Invalid username or password. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}


    //Designer login
    if (widget.type == 'designer') {
      print('designer');
      final QuerySnapshot designershot = await FirebaseFirestore.instance
          .collection('designer register')
          .where('email', isEqualTo: Email.text)
          .where('password', isEqualTo: Pass.text)
          // .where('status', isEqualTo: 1)
          .get();
      if (designershot.docs.isNotEmpty) {
        var userid = designershot.docs[0].id;
        var image_url = designershot.docs[0]['image_url'];
        var username = designershot.docs[0]['name'];
        print('_____________$username');
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('uid', userid);
        sp.setString('name', username);
        sp.setString('image_url', image_url);

        if (designershot.docs.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Login Successful ');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return DesignerNav();
          }));
        }
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    //rental login
    if (widget.type == 'rental') {
      print('rental');
      final QuerySnapshot rentalshot = await FirebaseFirestore.instance
          .collection('Rental register')
          .where('email', isEqualTo: Email.text)
          .where('password', isEqualTo: Pass.text)
          // .where('status', isEqualTo: 1)
          .get();
      if (rentalshot.docs.isNotEmpty) {
        var userid = rentalshot.docs[0].id;
         var image_url = rentalshot.docs[0]['image_url'];
        var username = rentalshot.docs[0]['name'];
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('uid',  userid);
        sp.setString('name', username);
        sp.setString('image', image_url);

        if (rentalshot.docs.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Login Successful ');

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return RentalNav();
          }));
        }
      } else {
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 300,
              child: Form(
                key: fkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text('Wed Vogue',
                        style: GoogleFonts.irishGrover(
                            color: const Color.fromARGB(255, 163, 33, 185),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)
                        //
                        ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('EMAIL'),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: Email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter email';
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          hintText: ('ENTER EMAIL')),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('PASSWORD'),
                        ),
                      ],
                    )),
                    TextFormField(
                      controller: Pass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Feild is empty';
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          hintText: ('ENTER YOUR PASSWORD')),
                    ),
                  Row(
  
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    InkWell(
      onTap: () {
        // Check the type and navigate accordingly
        if (widget.type == "designer") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassDesigner()),
          );
        } else if (widget.type == "mehandi") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassMehandi()),
          );
        } else if (widget.type == "makeup") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPass()),
          );
        } else if (widget.type == "rental") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassRental ()),
          );
        }
      },
      child: Text(
        "forgot password?",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Color.fromARGB(255, 20, 97, 160),
        ),
      ),
    ),
  ],
),

                    ElevatedButton(
                        onPressed: () async {
                          if (fkey.currentState!.validate()) {
                            print('-------------');
                            await gatData();
                            //  Navigator.push(context, MaterialPageRoute(builder:(context) {
                            //       return Navigationbar();
                            //     },));
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple)),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 244, 245)),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.type == 'designer') {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Desgn_Reg();
                            },
                          ));
                        } else if (widget.type == 'mehandi') {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Mehandi_Reg();
                            },
                          ));
                        } else if (widget.type == 'makeup') {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Makeup_Registration();
                            },
                          ));
                        } else if (widget.type == 'rental') {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Rental_Registration();
                            },
                          ));
                        } else if (widget.type == 'user') {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Registration();
                            },
                          ));
                        }
                      },
                      child: Text('Not Registered yet? Sign up'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
