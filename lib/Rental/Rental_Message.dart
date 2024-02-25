import 'package:flutter/material.dart';

class Rental_Message extends StatefulWidget {
  const Rental_Message({super.key});

  @override
  State<Rental_Message> createState() => _Rental_MessageState();
}

class _Rental_MessageState extends State<Rental_Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ENQUIRIES',style: TextStyle(color: Colors.deepPurpleAccent),)),
      ),
      body: Container(width: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(maxLines: 5,
                decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none),hintText: ('TYPE YOUR ENQUIRY')
              ),
               ),
            ),
            SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                
                }, child: Text('send')),
              ),
            ],
          )
          ],
        ),
      ),
       
    );
  }
}