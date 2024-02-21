import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
                Text('LOGIN',style: TextStyle(color: const Color.fromARGB(255, 163, 33, 185),fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                                  SizedBox(height:50,),
                                
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text('EMAIL'),
                                      ),
                                    ],
                                  ),
                                  TextFormField(decoration: InputDecoration
                                  (fillColor: Color.fromARGB(255, 224, 206, 221),filled:true,
                                    border: OutlineInputBorder
                                  (borderRadius: BorderRadius.all(Radius.circular(40))),
                                  hintText: ('ENTER EMAIL')),
                                  ),
                                  SizedBox(height: 30,),
                                  Container(child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text('PASSWORD'),
                                      ),
                                    ],
                                  )),
                                  TextFormField(
                                    decoration: InputDecoration(fillColor:Color.fromARGB(255, 224, 206, 221),filled:true,border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(40))
                                    ),
                                    hintText: ('ENTER YOUR PASSWORD')),
                                    
            
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("forgot password?"),
                                    ],
                                  ),
                                  SizedBox(height: 50,),
                                  ElevatedButton(onPressed: (){}, child: Text('LOGIN')),
                                  TextButton(onPressed: (){}, child: Text('Not Registered yet?Sign up'))
              ],
            ),
          ),
        ],
      ),
                        
    );
  }
}