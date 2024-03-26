import 'package:flutter/material.dart';

class User_Mehandi_Message extends StatefulWidget {
  const User_Mehandi_Message({Key? key});

  @override
  State<User_Mehandi_Message> createState() => _User_Mehandi_MessageState();
}

class _User_Mehandi_MessageState extends State<User_Mehandi_Message> {
  final TextEditingController _msgController = TextEditingController();
  List<String> _User_Mehandi_Messages = [];

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _User_Mehandi_Messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_User_Mehandi_Messages[index]),
                  // Align User_Mehandi_Messages to the right for user's User_Mehandi_Messages
                  trailing: index % 2 == 0 ? null : Icon(Icons.person),
                  // Align User_Mehandi_Messages to the left for responder's User_Mehandi_Messages
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
                    maxLines: 3,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 224, 206, 221),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: 'Type your User_Mehandi_Message here',
                      suffixIcon: Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: _sendUser_Mehandi_Message,
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
    );
  }

  void _sendUser_Mehandi_Message() {
    if (_msgController.text.isNotEmpty) {
      setState(() {
        _User_Mehandi_Messages.insert(0, _msgController.text); // Add user's User_Mehandi_Message
        _User_Mehandi_Messages.insert(0, 'Responder\'s reply'); // Add responder's reply
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
