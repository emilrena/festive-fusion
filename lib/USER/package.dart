import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPckg extends StatefulWidget {
  const UserPckg({super.key});

  @override
  State<UserPckg> createState() => _UserPckgState();
}

class _UserPckgState extends State<UserPckg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('packages')),
      body: ListView.builder(
        itemCount: 5,
        itemExtent: 120,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 204, 193, 200),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ],
          );
        },
      ),
    );
  }
}
