import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPckg extends StatefulWidget {
  const UserPckg({super.key});

  @override
  State<UserPckg> createState() => _UserPckgState();
}

class _UserPckgState extends State<UserPckg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('packages')
      ),
      body: 
      
                   
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text('select package type:',style:TextStyle(color: Colors.black87)
                
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,width: 300,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 204, 193, 200),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  
                ),
                 SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,width: 300,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 140, 126, 165),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  
                ),
                 SizedBox(
                  height: 20,
                ),
                
             Container(
                  height: 150,width: 300,
                  decoration: BoxDecoration(color:  Color.fromARGB(255, 204, 193, 200),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,width: 300,
                  decoration: BoxDecoration(color:   Color.fromARGB(255, 140, 126, 165),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  
                ),
                 SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: Text('NEXT',style: TextStyle(color: Colors.deepPurpleAccent),)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}