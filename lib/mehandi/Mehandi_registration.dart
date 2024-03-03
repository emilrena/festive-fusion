// import 'package:festive_fusion/USER/user_functions.dart';
import 'package:festive_fusion/mehandi/MehandiNav.dart';
import 'package:flutter/material.dart';

class Mehandi_Reg extends StatefulWidget {
  const Mehandi_Reg({super.key});

  @override
  State<Mehandi_Reg> createState() => _Mehandi_RegState();
}

class _Mehandi_RegState extends State<Mehandi_Reg> {
  String gender="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Mehandi_Reg')),
      ),
      body:
       SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 300,
                child: SingleChildScrollView(
                  
                    child: Column(
                      children: [
                        Container(
                          height: 50,width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 154, 134, 189)
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Name'),
                            ),
                          ],
                        ),
                        TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                        SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Email'),
                            ),
                          ],
                        ),
                        TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Gender'),
                            ),
                          ],
                        ),
                        RadioListTile(
                          title: Text('Male'),
                        
                        value: 'Male', groupValue: gender, onChanged: (value){
                          setState(() {
                            gender=value.toString();
                          });
                        }),
                        RadioListTile(
                          title: Text('Female'),
                        
                        value: 'Female', groupValue: gender, onChanged: (value){
                          setState(() {
                            gender=value.toString();
                          });
                        }),
                        RadioListTile(
                          title: Text('Others'),
                        
                        value: 'others', groupValue: gender, onChanged: (value){
                          setState(() {
                            gender=value.toString();
                          });
                        }),
                         Row(mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Text('Adress'),
                             ),
                           ],
                         ),
                        TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                         Row(mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Text('Year of Expriance'),
                             ),
                           ],
                         ),
                        TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                         Row(mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Text('District'),
                             ),
                           ],
                         ),
                      
                        TextFormField(keyboardType: TextInputType.phone,
                          decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Mobile Number'),
                            ),
                          ],
                        ),
                        TextFormField(keyboardType: TextInputType.phone,
                          decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('Password'),
                            ),
                          ],
                        ),
                        TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text('confirm password'),
                            ),
                          ],
                        ),
                        TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide.none)
                        
                          
                        ),),
                        SizedBox(height: 50,),
                        ElevatedButton(onPressed: () {
                           Navigator.push(context,MaterialPageRoute(builder: (context){
                    return MehandiNav();
                  }));
                          
                        }, child: Text('register')),
                    
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
             ),
      );
  }
}