import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesignerMessage extends StatefulWidget {
  const DesignerMessage({Key? key});

  @override
  State<DesignerMessage> createState() => _DesignerMessageState();
}

class _DesignerMessageState extends State<DesignerMessage> {
  final TextEditingController _msgController = TextEditingController();
  final fkey = GlobalKey<FormState>();
  List<String> _DesignerMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ENQUIRIES',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
        centerTitle: true,
      ),
      body: Form(key: fkey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _DesignerMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_DesignerMessages[index]),
                    // Align DesignerMessages to the right for user's DesignerMessages
                    trailing: index % 2 == 0 ? null : Icon(Icons.person),
                    // Align DesignerMessages to the left for responder's DesignerMessages
                    leading: index % 2 != 0 ? null : Icon(Icons.person),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _msgController,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'field is empty';
                          }
                          return null;
                        },
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 224, 206, 221),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        hintText: 'Type your DesignerMessage here',
                        suffixIcon: Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: _sendDesignerMessage,
                            child: Icon(Icons.send, size: 18),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(36, 36),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendDesignerMessage() async {
  if (_msgController.text.isNotEmpty && fkey.currentState!.validate()) {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var a = sp.getString('uid');
    await FirebaseFirestore.instance.collection('designer_message').add({
      'sender_message': _msgController.text,
      'designer_id': a,
    });
    setState(() {
      _DesignerMessages.insert(0, _msgController.text); // Add user's message
      _msgController.clear(); // Clear the text field
    });
  }
}


  @override
  void dispose() {
    _msgController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }
}
