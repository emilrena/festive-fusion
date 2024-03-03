import 'package:festive_fusion/Designers/EditService.dart';
import 'package:festive_fusion/Designers/packageadd.dart';
import 'package:flutter/material.dart';

class Vservice extends StatefulWidget {
  const Vservice({Key? key}) : super(key: key);

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
      body: 
     
      Container( decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/image1.jpg'),fit: BoxFit.cover),
                    ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 204, 193, 200),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.delete),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EditServices_();
                              }),
                            );
                          },
                          child: Icon(Icons.change_circle),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return package_add();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
