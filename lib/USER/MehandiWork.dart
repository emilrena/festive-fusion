import 'package:festive_fusion/USER/MehandiPackage.dart';
import 'package:festive_fusion/mehandi/Mehandi_message.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class MehandiWorkView extends StatefulWidget {
  const MehandiWorkView({super.key});

  @override
  State<MehandiWorkView> createState() => _MehandiWorkViewState();
}

class _MehandiWorkViewState extends State<MehandiWorkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text('WORK',style: TextStyle(color: Colors.deepPurple),
            
            ),
          ),
        ),
      ),
      body: Column(
        children: [
           Padding(
             padding: const EdgeInsets.only(left: 30),
             child: Row(mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 CircleAvatar(backgroundImage: AssetImage('Assets/p3.jpg'),radius: 30,),
                 IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Mehandi_Message();
                          },));
                 }, icon: Icon(Icons.message))
               ],
             ),
           ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ElevatedButton
                (onPressed: (){}, child: Text('WORKS',style: TextStyle(color: Colors.deepPurple),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)
                  ),
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ElevatedButton
                (onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return MehandiPackages();
                          },));
                }, child: Text('PACKAGES',style: TextStyle(color: Colors.black87),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)
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
    );
  }
}