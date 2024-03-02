import 'package:festive_fusion/USER/MehandiWork.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MehandiPackages extends StatefulWidget {
  const MehandiPackages({super.key});

  @override
  State<MehandiPackages> createState() => _MehandiPackagesState();
}

class _MehandiPackagesState extends State<MehandiPackages> {
  List c=[
    Colors.brown,Colors.red,Colors.purple
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Padding(
        padding: const EdgeInsets.only(right: 60),
        child: Text('PACKAGES',style: TextStyle(color: Color.fromARGB(221, 87, 4, 80)),),
      ))),
      body:Column(
        children: [
          Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ElevatedButton
            (onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return MehandiWorkView();
                          },));
            }, child: Text('WORKS',style: TextStyle(color: const Color.fromARGB(255, 15, 15, 15)),),
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
            (onPressed: (){}, child: Text('PACKAGES',style: TextStyle(color: Color.fromARGB(221, 75, 2, 82)),),
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
          itemCount: 5,
         
          itemBuilder: (context, index) {
            var a =index%2;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Booked();
                          },));
                  },
                    child: Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        
                          color:a==0? Color.fromARGB(255, 204, 193, 200):Color.fromRGBO(179, 124, 154, 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                    //  child: Container(
                                    //   height: 50,width: 50,color: Colors.amberAccent,
                                    //  ),
                                    child: SizedBox(height: 20,width: 10,
                    child: Row(
                      children: [
                        ClipRRect(borderRadius:BorderRadius.circular(20) ,child:Image.asset('Assets/mehandi.png',)),
                      ],
                    )),
                    ),
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
