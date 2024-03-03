import 'package:festive_fusion/Designers/DesignerNavigationBar.dart';
import 'package:festive_fusion/Designers/DesignerPeoplesBooked.dart';
import 'package:flutter/material.dart';

class DesignerProceed extends StatefulWidget {
  const DesignerProceed({Key? key}) : super(key: key);

  @override
  State<DesignerProceed> createState() => _DesignerProceedState();
}

class _DesignerProceedState extends State<DesignerProceed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTIFICATIONS',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 350,
            width: 200,
            margin: EdgeInsets.all(10), // Add margin for space between containers
            color: Color(0xFFFFFFFF),
            child: Column(
              
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('Assets/p4.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('ARON AROUSHANS'),
                    )
                  ],
                ),
                
                SizedBox(height: 10), // Add space between the circle and text
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('PACKAGE CHOOSED:',style: TextStyle(color: Color.fromARGB(221, 83, 6, 77)),),
                    ),
                   

                  
                  ],
                  
                ),
                SizedBox(height: 5,),
                 Padding(
                   padding: const EdgeInsets.only(right: 40),
                   child: Text('engagement and wedding day '),
                 ),
                 SizedBox(height:10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text('Date : ',style: TextStyle(color: Color.fromARGB(255, 92, 8, 71)),),
                    ),
                    Text(' 5/9/2024'),
                     SizedBox(height:10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text('Time : ',style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),),
                    ),
                   
                    Text('2.00 pm'),
                     SizedBox(height:10,),
                     Padding(
                       padding: const EdgeInsets.only(right: 240),
                       child: Text('Adress :  ',style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),),
                     ),
                    
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text('Thalancheri house chettipadi(po)'),
                    ),
                    SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child:ElevatedButton(onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context){
                    return DesignerNav();
                  }));
                          }, child: Text('Finished work'))
                        ),
                    
                      ],
                    )
              ],
            ),
          );
        },
      ),
    );
  }
}


