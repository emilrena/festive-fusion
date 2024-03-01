import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class RentHome extends StatefulWidget {
  const RentHome({super.key});

  @override
  State<RentHome> createState() => _RentHomeState();
}

class _RentHomeState extends State<RentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Icon(Icons.add)],
        title: Text('HOME',style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage('Assets/p4.jpg'),
                      radius: 35,  
                      ),
                    ],
                  ),Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('RENA FATHIMA'),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
             Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ElevatedButton
              (onPressed: (){}, child: Text('  CATEGORY  ',style: TextStyle(color: Colors.deepPurple),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.6),
                ),
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: ElevatedButton
              (onPressed: (){}, child: Text('   ENQUIRY   ',style: TextStyle(color: Color.fromARGB(221, 126, 10, 106)),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.6)
                ),
              ),
              ),
            ),
          ],
        ),
         SizedBox(height: 10,),
          Expanded(
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
          )
          ],
        ),
      ),
      
    );
  }
}