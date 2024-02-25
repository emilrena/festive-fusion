import 'package:flutter/material.dart';

class Booked extends StatefulWidget {
  const Booked({super.key});

  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking',style: TextStyle(color: Colors.deepPurpleAccent),),
      ),
      body:
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(width: 300,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('TIME:'),
                    ],
                  ),
               
               TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                                filled: true,
                                border: UnderlineInputBorder(
                                  
                                  borderSide: BorderSide.none)
                                
                                  
                                ),),
                                SizedBox(height: 20,),
                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('DATE:'),
                                  ],
                                ),
               
               TextFormField(decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                                filled: true,
                                border: UnderlineInputBorder(
                                  
                                  borderSide: BorderSide.none)
                                
                                  
                                ),),
            
                                SizedBox(height: 30,),
                                Text('SELECTED PACKAGE:'),
                                Container(
                                  height: 80,width: 300,
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 224, 206, 221),),
                                ),
            
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){}, child: Text('CHANGE')),
                                  ],
                                ),
                                 SizedBox(height: 20,),
                                Text(' CURRENT ADRESS:'),
                                Container(
                                  height: 80,width: 300,
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 224, 206, 221),),
                                ),
            
                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){}, child: Text('CHANGE')),
                                  ],
                                ),
                                ElevatedButton(onPressed: (){}, child: Text(' NEXT ',style:TextStyle(color: Colors.deepPurple),))
                                 ],
              ),
            ),
          ),
        ],
      )
    );
  }
}