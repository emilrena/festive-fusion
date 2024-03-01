       import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class GRidPage extends StatefulWidget {
  const GRidPage({super.key});

  @override
  State<GRidPage> createState() => _GRidPageState();
}

class _GRidPageState extends State<GRidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveGridList(
        desiredItemWidth: 150,
        minSpacing: 10,
        children: List.generate(20, (index)=> index+1).map((i) {
          return Container(
            height: 150,
            alignment: Alignment(0, 0),
            color: Color.fromARGB(255, 158, 124, 145),
            child: Text(i.toString()),
          );
        }).toList()
    )
    );
  }
}