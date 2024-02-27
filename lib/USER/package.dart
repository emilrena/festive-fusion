import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPckg extends StatefulWidget {
  const UserPckg({super.key});

  @override
  State<UserPckg> createState() => _UserPckgState();
}

class _UserPckgState extends State<UserPckg> {
  List c=[
    Colors.brown,Colors.red,Colors.purple
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('packages')),
      body: ListView.builder(
        itemCount: 5,
       
        itemBuilder: (context, index) {
          var a =index%2;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    
                      color:a==0? Color.fromARGB(255, 204, 193, 200):Color.fromRGBO(179, 124, 154, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
              //  child: Container(
              //   height: 50,width: 50,color: Colors.amberAccent,
              //  ),
              child: SizedBox(height: 20,width: 10,
                child: Row(
                  children: [
                    ClipRRect(borderRadius:BorderRadius.circular(20) ,child:Image.asset('Assets/image1.jpg',)),
                  ],
                )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
