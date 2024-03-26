import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message extends StatefulWidget {
  final String designer_id;

  const Message({Key? key, required this.designer_id}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController _msgController = TextEditingController();
  final fkey = GlobalKey<FormState>();
  List<String> _messages = [];
  late String selectedDesignerId;

  @override
  void initState() {
    super.initState();
    selectedDesignerId = widget.designer_id;
  }

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
      body: Form(
        key: fkey,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('designer_message')
                    .where('designer_id', isEqualTo: selectedDesignerId)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> messages = snapshot.data!.docs;

                  _messages = messages.map((message) => message['sender_message'].toString()).toList();

                  return ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_messages[index]),
                        trailing: Icon(Icons.person),
                        leading: Icon(Icons.person),
                      );
                    },
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
                          return 'Field is empty';
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
                        hintText: 'Type your message here',
                        suffixIcon: Container(
                          margin: EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: _sendMessage,
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

  void _sendMessage() async {
    if (_msgController.text.isNotEmpty && fkey.currentState!.validate()) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      var a = sp.getString('uid');
      await FirebaseFirestore.instance.collection('designer_message').add({
        'sender_message': _msgController.text,
        'user_id': a,
        'timestamp': FieldValue.serverTimestamp(),
        'designer_id': selectedDesignerId,
      });
      setState(() {
        _messages.insert(0, _msgController.text);
        _msgController.clear();
      });
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }
}
