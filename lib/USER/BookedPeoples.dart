import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:festive_fusion/USER/ViewBookingStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text('bookings'),
      ),
      
      body: SafeArea(
        child: Column(
          children: [Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: TextField(style: TextStyle(fontSize: 8),
              decoration: InputDecoration(
                labelText: 'SEARCH',
                border: OutlineInputBorder()
              ),
            ),
          ),SizedBox(height: 20,),
            // Center(child: Text('PROFESIONALS')),
            Expanded(
              child: ListView.builder(
                 itemCount: 3,
                
                itemBuilder: (context, index) {
                  return  ListTile(
                  onTap: () {},
                  title: Text('name'),
                  subtitle: SizedBox(width: 5,
                    child: RatingBar.builder(itemSize: 20,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 3,
                        color: Color.fromARGB(255, 124, 4, 94),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  leading: CircleAvatar(backgroundImage: AssetImage('Assets/p2.jpg'),
                  radius: 30,
                  ),
                  trailing:ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return MyBookingsStatus();
                          },));
                  },
                            style:ElevatedButton.styleFrom(padding:EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0), 
                            backgroundColor:Colors.deepPurple,
                            ), child: Text('view'
                           , style: TextStyle(color: const Color.fromARGB(255, 231, 234, 236),fontSize: 10),
                            
                            )) 
                  // Icon(Icons.delete),
                          );
                
              },),
            ),
          ],
        ),
      ),
    );
  }
}