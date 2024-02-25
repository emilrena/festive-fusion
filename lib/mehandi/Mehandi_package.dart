import 'package:flutter/material.dart';

class Mehndi_package_add extends StatefulWidget {
  const Mehndi_package_add({super.key});

  @override
  State<Mehndi_package_add> createState() => _Mehndi_package_addState();
}

class _Mehndi_package_addState extends State<Mehndi_package_add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Center(child: Text('PACKAGE')),
      ),
      body: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/mehandi.png'),fit: BoxFit.cover),
                    ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 28,right: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                TextFormField(decoration: InputDecoration(hintText:'service',
                  fillColor: Color.fromARGB(255, 182, 174, 196),
                                        filled: true,
                                        border: UnderlineInputBorder(
                                          
                                          borderSide: BorderSide.none)
                                        
                                          
                                        ),
                
                ),SizedBox(height: 30,),
                TextFormField(maxLines: 5,
                  decoration: InputDecoration(hintText: 'Describe here',
                    fillColor: Color.fromARGB(255, 182, 174, 196),
                                        filled: true,
                                        border: UnderlineInputBorder(
                                          
                                          borderSide: BorderSide.none)
                                        
                                          
                                        ),
                
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: (){}, 
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 206, 197, 221))),
                    child: Text('SUBMIT',style: TextStyle(color: Colors.black87),)),
                  ],
                )
            
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}