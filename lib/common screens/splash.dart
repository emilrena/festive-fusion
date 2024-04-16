import 'dart:async';

import 'package:festive_fusion/common%20screens/UserType.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 8),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TypeUser()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 235, 229, 234),
              Color.fromARGB(255, 250, 244, 249),
            ],
          ),
        ),
        child: Center(child:  Text('Wed Vogue',
                        style: GoogleFonts.irishGrover(
                            color: const Color.fromARGB(255, 163, 33, 185),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)
                        //
                        ),
          // child: Image.asset(
          //   'Assets/b.png',
          //   fit: BoxFit.contain,
          // ),
        ),
      ),
    );
  }
}
