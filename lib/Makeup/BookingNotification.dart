import 'package:flutter/material.dart';

class MakeupNotification extends StatefulWidget {
  const MakeupNotification({super.key});

  @override
  State<MakeupNotification> createState() => _MakeupNotificationState();
}

class _MakeupNotificationState extends State<MakeupNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('NOTIFICATIONS',style: TextStyle(color: Colors.deepPurpleAccent),),  
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          
        },),
    );
  }
}