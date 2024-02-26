import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME',style: TextStyle(color: Color.fromARGB(255, 15, 15, 15)),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text('CREATE YOUR DAY WITH US ',style: TextStyle(color: const Color.fromARGB(255, 104, 7, 121),fontSize: 15,),),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(height: 100,width: 300,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('Assets/image1.jpg'),
                      
                          
                          
                    ),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [//Expanded(child: Padding(padding: const EdgeInsets.all(2),)),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Text('DESIGNERS',style: TextStyle(fontSize: 20,color: Colors.black87),),
                     ),
                   ],
                 ) ],
                ),
              ),
            ),SizedBox(height: 10,),
            
             Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(height: 100,width: 300,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('Assets/wrk3.jpg'),
                      
                          
                          
                    ),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [//Expanded(child: Padding(padding: const EdgeInsets.all(2),)),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Text('RENTALS',style: TextStyle(fontSize: 20,color: Colors.black87),),
                     ),
                   ],
                 ) ],
                ),
              ),
            ),SizedBox(height: 10,),
             Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(height: 100,width: 300,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('Assets/makeup.webp'),
                      
                          
                          
                    ),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [//Expanded(child: Padding(padding: const EdgeInsets.all(2),)),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Text('MAKEUP',style: TextStyle(fontSize: 20,color: Colors.black87),),
                     ),
                   ],
                 ) ],
                ),
              ),
            ),SizedBox(height: 10,),
             Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(height: 100,width: 300,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('Assets/mehandi.png'),
                      
                          
                          
                    ),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [//Expanded(child: Padding(padding: const EdgeInsets.all(2),)),
                     Padding(
                       padding: const EdgeInsets.only(left: 40),
                       child: Text('MEHANDI',style: TextStyle(fontSize: 20,color: Colors.black87),),
                     ),
                   ],
                 ) ],
                ),
              ),
            ),
            
            ],
          ),
        ),
      ),
      
    );
  }
}