import 'package:festive_fusion/Navigationbar.dart';
import 'package:festive_fusion/USER/functions.dart';
import 'package:festive_fusion/registration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      'Festive Fusion',
                      style: GoogleFonts.irishGrover( color: const Color.fromARGB(255, 163, 33, 185), 
                      fontSize: 30,
                         fontWeight: FontWeight.bold)
                      //    
                      )
                    ,
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
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40))),
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
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 224, 206, 221),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40))),
                          hintText: ('ENTER YOUR PASSWORD')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("forgot password?",style: TextStyle(decoration: TextDecoration.underline,color: Color.fromARGB(255, 20, 97, 160)),),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Navigationbar();
                          },));

                    }, 
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple)),
                    child: Text('LOGIN',style: TextStyle(color: Color.fromARGB(255, 245, 244, 245)),)),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Functions_user();
                          },));
                        }, child: Text('Not Registered yet?Sign up'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
