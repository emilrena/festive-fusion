import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message extends StatefulWidget {
  final String designer_id;

  Message({Key? key, required this.designer_id}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('messages').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index].data() as Map<String, dynamic>?;

                    if (message != null &&
                        message.containsKey('text') &&
                        message.containsKey('sender')) {
                      final text = message['text'] as String?;
                      final sender = message['sender'] as String?;

                      if (text != null && sender != null) {
                        return ListTile(
                          title: Text(text),
                          subtitle: Text(sender),
                        );
                      }
                    }

                    return SizedBox(); // Return an empty SizedBox if any required data is null
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_messageController.text.isNotEmpty) {
                      // Retrieve the logged-in user ID from shared preferences
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? userId = prefs.getString('uid');

                      // Add the message to the Firestore collection
                      await FirebaseFirestore.instance.collection('user_designer_message').add({
                        'text': _messageController.text,
                        'user_id': userId ?? 'Unknown', // Use the retrieved user ID
                        'timestamp': Timestamp.now(),
                        'designer_id': widget.designer_id,
                      });
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
