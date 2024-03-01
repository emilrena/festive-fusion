import 'package:flutter/material.dart';

class RentalFullProfile extends StatefulWidget {
  const RentalFullProfile({super.key});

  @override
  State<RentalFullProfile> createState() => _RentalFullProfileState();
}

class _RentalFullProfileState extends State<RentalFullProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('Assets/p2.jpg'),
              ),
              SizedBox(height: 30,),
            Text('name:rena'),
            SizedBox(height: 20,),
            Text('Email:rr@gmail.com'),
            SizedBox(height: 20,),
            Text('Gender:Female'),
            SizedBox(height: 20,),
            Text('Adress:thalancher house'),
            SizedBox(height: 20,),
            Text('Expearance:2 years'),
            SizedBox(height: 20,),
            Text('state:kozhikkode'),
            SizedBox(height: 20,),
            Text('phone no:9497422413'),
          
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){},
                                style:ElevatedButton.styleFrom(padding:EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0), 
                                backgroundColor:Colors.deepPurple,
                                ), child: Text('BLOCK'
                               , style: TextStyle(color: const Color.fromARGB(255, 231, 234, 236),fontSize: 10),
                                
                                )) 
            
            ],
          ),
        ],
      ),
    );
  }
}