import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends StatefulWidget {
  final String userId;
  final String receiverId;
  final String imageUrl;
  final String propertyName;

  const MessagePage({
    Key? key,
    required this.userId,
    required this.receiverId,
    required this.imageUrl,
    required this.propertyName,
  }) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _controller = TextEditingController();
  String userName = '';
  String profileImage = 'assets/images/profile.png'; // Default profile image

  @override
  void initState() {
    super.initState();
    _getUserProfile(widget.receiverId);
  }

  String _getChatDocumentPath() {
    List<String> ids = [widget.userId, widget.receiverId];
    ids.sort(); // Ensure consistent document path
    return ids.join('-');
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    try {
      final timestamp = FieldValue.serverTimestamp();
      final messageText = _controller.text.trim();

      // Add message to Firestore
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(_getChatDocumentPath())
          .collection('chatMessages')
          .add({
        'senderId': widget.userId,
        'receiverId': widget.receiverId,
        'message': messageText,
        'timestamp': timestamp,
        'status': 'sent',
      });

      // Update inbox for both users
      await _updateInbox(
          widget.userId, widget.receiverId, messageText, timestamp);
      await _updateInbox(
          widget.receiverId, widget.userId, messageText, timestamp);

      _controller.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Future<void> _getUserProfile(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          userName = data['name'] ?? 'Unknown';
          profileImage = data['profileImage'] != null &&
                  Uri.parse(data['profileImage']).isAbsolute
              ? data['profileImage']
              : 'assets/images/profile.png';
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Unknown';
        profileImage = 'assets/images/profile.png';
      });
      print('Error fetching user profile: $e');
    }
  }

  Future<void> _updateInbox(
      String userId, String otherUserId, String message, var timestamp) async {
    try {
      var inboxRef = FirebaseFirestore.instance.collection('inbox');

      // Fetch inbox documents where the current user is a part of the conversation
      var inboxDoc =
          await inboxRef.where('userIds', arrayContains: userId).get();

      // Try to find a matching document where both users are part of the conversation
      QueryDocumentSnapshot<Map<String, dynamic>>? matchingDoc =
          inboxDoc.docs.firstWhereOrNull(
        (doc) => List<String>.from(doc['userIds']).contains(otherUserId),
      );

      if (matchingDoc == null) {
        // If no matching document, create a new thread
        await inboxRef.add({
          'userIds': [userId, otherUserId],
          'lastMessage': message,
          'lastMessageTimestamp': timestamp,
          'unreadCount': userId == widget.receiverId
              ? 1
              : 0, // Increment unread count for receiver
        });
      } else {
        // If a matching document is found, update it with the latest message
        await inboxRef.doc(matchingDoc.id).update({
          'lastMessage': message,
          'lastMessageTimestamp': timestamp,
          'unreadCount': userId == widget.receiverId
              ? FieldValue.increment(1)
              : 0, // Reset unread count for sender
        });
      }
    } catch (e) {
      print('Error updating inbox: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> _getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(_getChatDocumentPath())
        .collection('chatMessages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return {
                'senderId': data['senderId'],
                'receiverId': data['receiverId'],
                'message': data['message'],
                'timestamp': data['timestamp'] ?? Timestamp.now(),
                'status': data['status'],
              };
            }).toList());
  }

  Widget _buildMessageBubble({
    required bool isSender,
    required String message,
    required Timestamp timestamp,
    required String status,
  }) {
    final time =
        timestamp.toDate().toLocal().toString().split(' ')[1].substring(0, 5);
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSender)
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.imageUrl),
          ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              const SizedBox(height: 5),
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              // Handle file attachment
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            const SizedBox(width: 10),
            Text(
              widget.propertyName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching messages'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _buildMessageBubble(
                        isSender: message['senderId'] == widget.userId,
                        message: message['message'],
                        timestamp: message['timestamp'],
                        status: message['status'],
                      );
                    },
                  );
                }
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }
}
