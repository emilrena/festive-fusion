import 'package:flutter/material.dart';

class MakeupHome extends StatefulWidget {
  const MakeupHome({super.key});

  @override
  State<MakeupHome> createState() => _MakeupHomeState();
}

class _MakeupHomeState extends State<MakeupHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Icon(Icons.add)],
        title: Text('HOME',style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage('Assets/p4.jpg'),
                      radius: 35,  
                      ),
                    ],
                  ),Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('RENA FATHIMA'),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
             Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ElevatedButton
              (onPressed: (){}, child: Text('  PACKAGES  ',style: TextStyle(color: Colors.deepPurple),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.6),
                ),
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: ElevatedButton
              (onPressed: (){}, child: Text('   ENQUIRY   ',style: TextStyle(color: Color.fromARGB(221, 126, 10, 106)),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.6)
                ),
              ),
              ),
            ),
          ],
        ),
          ],
        ),
      ),
      
    );
  }
}