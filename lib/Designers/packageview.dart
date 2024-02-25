import 'package:flutter/material.dart';

class Vservice extends StatefulWidget {
  const Vservice({super.key});

  @override
  State<Vservice> createState() => _VserviceState();
}

class _VserviceState extends State<Vservice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/image1.jpg'),fit: BoxFit.cover),
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
                        Icon(Icons.change_circle)
                      ],
                    )
                  ]),
            ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.black87,))
                ],
              )
          
          
          
            ],
          ),
        ),
      ),
    );
  }
}