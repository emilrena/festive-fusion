import 'package:flutter/material.dart';

class DesignerMessage extends StatefulWidget {
  const DesignerMessage({super.key});

  @override
  State<DesignerMessage> createState() => _DesignerMessageState();
}

class _DesignerMessageState extends State<DesignerMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ENQUIRIES',style: TextStyle(color: Colors.deepPurpleAccent),)),
      ),
      body: Container(width: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: TextFormField(maxLines: 5,
                decoration: InputDecoration(fillColor: Color.fromARGB(255, 224, 206, 221),
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide.none),hintText: ('Type your DesignerMessage here')
              ),
               ),
            ),
            SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                
                }, child: Text('send')),
              ),
            ],
          )
          ],
        ),
      ),
       
    );
  }
}