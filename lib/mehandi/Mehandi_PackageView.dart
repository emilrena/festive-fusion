import 'package:festive_fusion/mehandi/Mehandi_package.dart';
import 'package:festive_fusion/mehandi/Mehandi_packageEdit.dart';
import 'package:flutter/material.dart';

class Mehndi_package_view extends StatefulWidget {
  const Mehndi_package_view({super.key});

  @override
  State<Mehndi_package_view> createState() => _Mehndi_package_viewState();
}

class _Mehndi_package_viewState extends State<Mehndi_package_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/mehandi.png'),fit: BoxFit.cover),
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
                        InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Mehndi_package_add();
                          },));
                          
                        },
                          child: Icon(Icons.delete)),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Mehndi_package_edit();
                          },));

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

     Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return Mehndi_package_add();
                          },));


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