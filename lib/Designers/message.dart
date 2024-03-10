import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festive_fusion/Designers/DesignerNavigationBar.dart';
import 'package:flutter/material.dart';

class DesignerMessage extends StatefulWidget {
  const DesignerMessage({Key? key}) : super(key: key);

  @override
  State<DesignerMessage> createState() => _DesignerMessageState();
}

class _DesignerMessageState extends State<DesignerMessage> {
  var Message = TextEditingController();
  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ENQUIRIES',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
        ),
      ),
      body: Form(
        key: fkey,
        child: Container(
          width: 350,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: Message,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field is empty';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 224, 206, 221),
                    filled: true,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: ('TYPE YOUR ENQUIRY'),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: ()   async {
                            await FirebaseFirestore.instance
                                .collection(' designer message')
                                .add({
                              'message': Message.text,
                              
                              
                            });
                        if (fkey.currentState!.validate()) {
                          print(Message.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DesignerNav();
                            }),
                          );
                        }
                      },
                      child: Text('send'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
