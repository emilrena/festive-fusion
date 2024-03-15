import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Makeup_Message extends StatefulWidget {
  const Makeup_Message({super.key});

  @override
  State<Makeup_Message> createState() => _Makeup_MessageState();
}

class _Makeup_MessageState extends State<Makeup_Message> {
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
        )),
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
                          borderSide: BorderSide.none),
                      hintText: ('TYPE YOUR ENQUIRY')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                           SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        var a = sp.getString('uid');
                            await FirebaseFirestore.instance
                                .collection('makeup message ')
                                .add({
                              'message': Message.text,
                              
                              
                              
                            });
                          if (fkey.currentState!.validate()) {
                            print(Message.text);
                          }
                        },
                        child: Text('send')),
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
