import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/USER/DesignerWork.dart';
import 'package:festive_fusion/USER/booking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPckg extends StatefulWidget {
  final String designer_id; // Designer ID received from the previous screen

  const UserPckg({Key? key, required this.designer_id,}) : super(key: key);

  @override
  State<UserPckg> createState() => _UserPckgState();
}

class _UserPckgState extends State<UserPckg> {
  late List<DocumentSnapshot> _packages;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(' designer_package ')
          .where('designer_id', isEqualTo: widget.designer_id)
          .get();
      setState(() {
        _packages = snapshot.docs;
        _isLoading = false;
      });
    } catch (error) {
      print('Error loading packages: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }
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
                            return DesignerWork(designer_id:'');
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
                        ClipRRect(borderRadius:BorderRadius.circular(20) ,child:Image.asset('Assets/image1.jpg',)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('complete outfit'),
                      )],
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
