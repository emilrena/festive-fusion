import 'package:festive_fusion/Makeup/Makeup_PackageEdit.dart';
import 'package:festive_fusion/Makeup/Makeup_package.dart';
import 'package:flutter/material.dart';

class Makeup_Package_View extends StatefulWidget {
  const Makeup_Package_View({super.key});

  @override
  State<Makeup_Package_View> createState() => _Makeup_Package_ViewState();
}

class _Makeup_Package_ViewState extends State<Makeup_Package_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/makeup.webp'),fit: BoxFit.cover),
                    ),
        child: Padding(
          padding: const EdgeInsets.only(left: 28,right: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Container(
               height: 150,width: 300,
                decoration: BoxDecoration(color: Color.fromARGB(255, 204, 193, 200),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.delete),
                        SizedBox(
                          height: 50,
                        ),
                        Icon(Icons.change_circle)
                      ],
                    )
                  ]),
            )
              
              ,SizedBox(height: 30,),
              Container(
               height: 150,width: 300,
                decoration: BoxDecoration(color: Color.fromARGB(255, 204, 193, 200),
                
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.delete),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Package_Edit();
                  }));
                        },
                          child: Icon(Icons.change_circle))
                      ],
                    )
                  ]),
            ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Makeup_Package_Add();
                  }));
                  }, icon: Icon(Icons.add,color: Colors.black87,))
                ],
              )
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}