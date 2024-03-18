import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/ADMIN/AdminNavigationBar.dart';
import 'package:festive_fusion/Designers/DesignerNavigationBar.dart';
import 'package:festive_fusion/Makeup/MakupNav.dart';
import 'package:festive_fusion/Navigationbar.dart';
import 'package:festive_fusion/Rental/RentalNav.dart';
import 'package:festive_fusion/USER/functions.dart';
import 'package:festive_fusion/mehandi/MehandiNav.dart';
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
    if(widget.type=='mehandi')  {
      print('Mehendi');
      final QuerySnapshot mechSnapshot =
        await FirebaseFirestore.instance
            .collection('Mehandi register')
            .where('email', isEqualTo: Email.text)
            .where('password', isEqualTo: Pass.text)
            // .where('status', isEqualTo: 1)
            .get();
             if(mechSnapshot.docs.isNotEmpty){
  var userid = mechSnapshot.docs[0].id;
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString('uid',userid);

              if (mechSnapshot.docs.isNotEmpty) {

      Fluttertoast.showToast(msg: 'Login Successful ');
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MehandiNav();
          }));
              } } 
       else {
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

    if(widget.type=='user')  {
      print('user');
      final QuerySnapshot usershot =
        await FirebaseFirestore.instance
            .collection('User_Registration')
            .where('email', isEqualTo: Email.text)
            .where('password', isEqualTo: Pass.text)
            // .where('status', isEqualTo: 1)
            .get();

            if(usershot.docs.isNotEmpty){
  var userid = usershot.docs[0].id;
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString('uid',userid);

              if (usershot.docs.isNotEmpty) {

      Fluttertoast.showToast(msg: 'Login Successful ');
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Navigationbar();
         }));
    } }
       else {
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
    if(widget.type=='makeup')  {
      print('__________makeup');
      final QuerySnapshot makeupshot =
        await FirebaseFirestore.instance
            .collection('Makeup register')
            .where('email', isEqualTo: Email.text)
            .where('password', isEqualTo: Pass.text)
            // .where('status', isEqualTo: 1)
            .get();
             if(makeupshot.docs.isNotEmpty){
              print('_________________________________');
  var userid = makeupshot.docs[0].id;
  print('userid:_____$userid');
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString('uid',userid);

              if (makeupshot.docs.isNotEmpty) {

      Fluttertoast.showToast(msg: 'Login Successful ');
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MakeupNav();
          }));
              } } 
       else {
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
    //Designer login
     if(widget.type=='designer')  {
      print('designer');
      final QuerySnapshot designershot =
        await FirebaseFirestore.instance
            .collection('designer register')
            .where('email', isEqualTo: Email.text)
            .where('password', isEqualTo: Pass.text)
            // .where('status', isEqualTo: 1)
            .get();
             if(designershot.docs.isNotEmpty){
  var userid = designershot.docs[0].id;
  var image_url = designershot.docs[0]['image_url'];
  var username = designershot.docs[0]['name'];
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString('uid',userid);
  sp.setString('name', username);
  sp.setString('image_url',image_url);

              if (designershot.docs.isNotEmpty) {

      Fluttertoast.showToast(msg: 'Login Successful ');
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DesignerNav();
          }));
             }} 
       else {
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
 if(widget.type=='rental')  {
      print('rental');
      final QuerySnapshot rentalshot =
        await FirebaseFirestore.instance
            .collection('Rental register')
            .where('email', isEqualTo: Email.text)
            .where('password', isEqualTo: Pass.text)
            // .where('status', isEqualTo: 1)
            .get();
             if(rentalshot.docs.isNotEmpty){
  var userid = rentalshot.docs[0].id;
    var username = rentalshot.docs[0]['name'];
    var image_url = rentalshot.docs[0]['image'];

  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString('uid',userid);
  sp.setString('name', username);
  sp.setString('image',image_url);


              if (rentalshot.docs.isNotEmpty) {

      Fluttertoast.showToast(msg: 'Login Successful ');
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return RentalNav();
          }));
             }} 
       else {
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
                    Text('Festive Fusion',
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
                        Text(
                          "forgot password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 20, 97, 160)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                        
                          if (fkey.currentState!.validate()) {
                            print('-------------');
                            gatData();
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Functions_user();
                            },
                          ));
                        },
                        child: Text('Not Registered yet?Sign up'))
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
