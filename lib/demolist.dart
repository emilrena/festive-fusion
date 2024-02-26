import 'package:festive_fusion/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            color: Colors.amber,child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                },));
              },
              child: Text('data')),
          ),),
        );
        // return ListTile(
        //   onTap: () {},
        //   title: Text('name'),
        //   subtitle: RatingBar.builder(
        //     initialRating: 3,
        //     minRating: 1,
        //     direction: Axis.horizontal,
        //     allowHalfRating: true,
        //     itemCount: 5,
        //     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        //     itemBuilder: (context, _) => Icon(
        //       Icons.star,
        //       color: Colors.amber,
        //     ),
        //     onRatingUpdate: (rating) {
        //       print(rating);
        //     },
        //   ),
        //   leading: CircleAvatar(backgroundImage: AssetImage('Assets/wrk2.jpg')),
        //   trailing: Icon(Icons.delete),
        // );
      },
    ));
  }
}
