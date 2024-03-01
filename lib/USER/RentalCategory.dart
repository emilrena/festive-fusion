import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalCategory extends StatefulWidget {
  const RentalCategory({super.key});

  @override
  State<RentalCategory> createState() => _RentalCategoryState();
}

class _RentalCategoryState extends State<RentalCategory> {
  List c=[
    Colors.brown,Colors.red,Colors.purple
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Padding(
        padding: const EdgeInsets.only(right: 60),
        child: Text('CATEGORY',style: TextStyle(color: Color.fromARGB(221, 87, 4, 80)),),
      ))),
      body:Column(
        children: [
          Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ElevatedButton
            (onPressed: (){}, child: Text('WORKS',style: TextStyle(color: const Color.fromARGB(255, 15, 15, 15)),),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)
              ),
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ElevatedButton
            (onPressed: (){}, child: Text('CATEGORY',style: TextStyle(color: Color.fromARGB(221, 75, 2, 82)),),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)
              ),
            ),
            ),
          ),
        ],
  
      ),
      
      
       Expanded(
         child: ListView.builder(
          itemCount: 7,
         
          itemBuilder: (context, index) {
            var a =index%2;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      
                        color:a==0? Color.fromARGB(255, 204, 193, 200):Color.fromRGBO(179, 124, 154, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                //  child: Container(
                //   height: 50,width: 50,color: Colors.amberAccent,
                //  ),
                 border: Border.all(
                            color: Color.fromARGB(255, 94, 87, 1), // Change this to the desired color
                            width: 2.0, // Change this to the desired border width
                          ),
                        ),
                child: SizedBox(height: 20,width: 10,
                  child: Row(
                    children: [
                      ClipRRect(borderRadius:BorderRadius.circular(20) ,child:Image.asset('Assets/wrk3.jpg',)),
                    ],
                  )),
                  ),
                ],
              ),
            );
          },
               ),
       ),
        ]
    )
    );
  }
}
