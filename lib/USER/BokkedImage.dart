import 'package:flutter/material.dart';

class AfterBooked extends StatefulWidget {
  const AfterBooked({Key? key}) : super(key: key);

  @override
  State<AfterBooked> createState() => _AfterBookedState();
}

class _AfterBookedState extends State<AfterBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('Assets/b.png'), // Make sure your asset path is correct
          ),
        ),
      ),
    );
  }
}
