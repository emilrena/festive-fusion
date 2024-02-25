import 'package:flutter/material.dart';

class UsPayment extends StatefulWidget {
  const UsPayment({super.key});

  @override
  State<UsPayment> createState() => _UsPaymentState();
}

class _UsPaymentState extends State<UsPayment> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment'),
      ),
      
    );
  }
}