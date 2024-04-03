import 'package:festive_fusion/Rental/Rental_UploadImage.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:  InkWell(onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder:(context) {
        //                     return Rental_Upload_pic();
        //                   },));
      },
        child: ResponsiveGridList(
                      desiredItemWidth: 150,
                      minSpacing: 10,
                      children: List.generate(20, (index)=> index+1).map((i) {
              return Container(
                height: 150,
                alignment: Alignment(0, 0),
                color: Color.fromARGB(255, 165, 146, 159),
                child: Text(i.toString()),
              );
                      }).toList()
                  ),
      ),
          );
  }
}