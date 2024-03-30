
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ConfirmBokkings extends StatefulWidget {
  const ConfirmBokkings({Key? key}) : super(key: key);

  @override
  State<ConfirmBokkings> createState() => _ConfirmBokkingsState();
}

class _ConfirmBokkingsState extends State<ConfirmBokkings> {

  @override
  TextEditingController feedbackController = TextEditingController();
  void showFeedbackPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Give Feedback"),
          
          content: Column(
            children: [SizedBox(height: 50,),
              RatingBar.builder(itemSize: 40,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                // controller: feedbackController,
                // maxLines: 4,
               itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 3,
                        color: Color.fromARGB(255, 124, 4, 94),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add your logic to handle feedback submission
                String feedbackText = feedbackController.text;
                // You can send the feedback to your server or handle it as needed
                print("Feedback submitted: $feedbackText");

                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: Text("Send Feedback"),
            ),
            TextButton(
              onPressed: () {
                // Close the pop-up
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTIFICATIONS',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      body: Container(
            height: 600,
            width: 400,
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
                     Text('2.00 pm'),
                     SizedBox(height:10,),
                     Padding(
                       padding: const EdgeInsets.only(right: 240),
                       child: Text('STATUS :  ',style: TextStyle(color: Color.fromARGB(255, 83, 4, 70)),),
                     ),
                    
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text('APPROVED'),
                    ),
                    
                    SizedBox(height: 20,),
                    ElevatedButton(
                onPressed: () {
                  showFeedbackPopup(context);
                },
                child: Text('Give Feedback'),
              ),
             
             ],
            ),
          )
        
      
    );
  }
}
