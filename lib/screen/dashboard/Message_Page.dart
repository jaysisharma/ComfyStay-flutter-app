import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _controller = TextEditingController();
  
  // This list will hold all messages with their sender status
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello from sender', 'isSender': true},
    {'text': 'Hello from receiver', 'isSender': false},
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        // Add a new message with the sender status
        _messages.add({'text': _controller.text, 'isSender': true});
        _controller.clear(); // Clear the text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/roomcard.jpeg"),
            ),
            SizedBox(width: 20),
            Text('Message Page'),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final messageData = _messages[index];
                return _messageBubble(
                  isSender: messageData['isSender'],
                  message: messageData['text'],
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _messageBubble({required bool isSender, required String message}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) 
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/room.png"),
            ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: isSender ? Colors.blue[100] : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: EdgeInsets.all(12.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 15),
            ),
          ),
          if (isSender) 
            SizedBox(width: 10),
          if (isSender) 
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/room.png"),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.keyboard),
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
