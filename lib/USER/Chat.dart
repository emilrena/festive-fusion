import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  ChatScreen({required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _currentUserUid;
  late ScrollController _scrollController;
  late String chatRoomId;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserUid();
    _scrollController = ScrollController();
  }

  // Function to fetch current user's ID from SharedPreferences
  Future<void> fetchCurrentUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentUserUid = prefs.getString('uid') ?? '';
      chatRoomId = generateChatRoomId();
    });
  }

  // Function to generate chat room ID
  String generateChatRoomId() {
    List<String> ids = [_currentUserUid, widget.receiverId];
    ids.sort();
    return ids.join("_");
  }

  // Function to send a message
  void _sendMessage(String messageText) {
    // Add a document to the 'chat_rooms' collection
    var chatRoomRef = _firestore.collection('chat_rooms').doc(chatRoomId);
    chatRoomRef.set({}); // Create the chatroom document if it doesn't exist

    // Add the message to the 'messages' collection within the chatroom
    chatRoomRef.collection('messages').add({
      'text': messageText,
      'time': Timestamp.now(),
      'senderId': _currentUserUid,
      'receiverId': widget.receiverId,
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                // Listen to changes in the 'messages' collection within the chat room
                stream: _firestore
                    .collection('chat_rooms')
                    .doc(chatRoomId)
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final messages = snapshot.data!.docs;
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                  List<Widget> messageWidgets = [];
                  for (var message in messages) {
                    final messageText = message['text'];
                    final senderId = message['senderId'];
                    final receiverId = message['receiverId'];
                    // Check if the message is sent by the current user or received by the selected receiver
                    final isCurrentUser = senderId == _currentUserUid;
                    final isReceiver = receiverId == widget.receiverId;
                    if (isCurrentUser || isReceiver) {
                      final messageWidget = MessageBubble(
                        message: messageText,
                        isCurrentUser: isCurrentUser,
                      );
                      messageWidgets.add(messageWidget);
                    }
                  }
                  return ListView(
                    controller: _scrollController,
                    reverse: true,
                    children: messageWidgets,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Expanded(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          _sendMessage(_messageController.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  MessageBubble({required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
