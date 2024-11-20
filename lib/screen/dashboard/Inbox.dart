import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comfystay/screen/dashboard/Message_Page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  // Fetch recent messages
  Stream<List<Map<String, dynamic>>> _getRecentMessages(String userId) {
    return FirebaseFirestore.instance
        .collection('inbox')
        .where('userIds', arrayContains: userId)
        .orderBy('lastMessageTimestamp', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      final uniqueDocs = snapshot.docs.toSet(); // Avoid duplicate docs
      return uniqueDocs.map((doc) {
        var userIds = List<String>.from(doc['userIds']);
        var receiverId = userIds.firstWhere((id) => id != userId); // Get receiver ID
        return {
          'threadId': doc.id, // Unique thread ID
          'lastMessage': doc['lastMessage'],
          'lastMessageTimestamp': doc['lastMessageTimestamp'],
          'receiverId': receiverId,
          'unreadCount': doc['unreadCount'] ?? 0, // Handle missing unreadCount
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getRecentMessages(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching messages'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No messages'));
          } else {
            var messages = snapshot.data!;
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _messageCard(
                  key: ValueKey(message['threadId']), // Unique key for each card
                  userId: userId,
                  receiverId: message['receiverId'],
                  message: message['lastMessage'],
                  unreadCount: message['unreadCount'],
                  timestamp: message['lastMessageTimestamp'],
                  context: context,
                );
              },
            );
          }
        },
      ),
    );
  }

  // Message card UI
  Widget _messageCard({
    required Key key,
    required String userId,
    required String receiverId,
    required String message,
    required int unreadCount,
    required Timestamp timestamp,
    required BuildContext context,
  }) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserProfile(receiverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error fetching profile'));
        } else {
          final userProfile = snapshot.data!;
          String time = _formatTimestamp(timestamp);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
                      userId: userId,
                      receiverId: receiverId,
                      imageUrl: userProfile['profileImage'],
                      propertyName: '',
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userProfile['profileImage']),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile['name'] ?? 'No Name',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          message,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      if (unreadCount > 0)
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Format the timestamp for display
  String _formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    String period = date.hour < 12 ? 'AM' : 'PM';
    int hour = date.hour % 12 == 0 ? 12 : date.hour % 12; // Convert to 12-hour format
    String minute = date.minute < 10 ? '0${date.minute}' : date.minute.toString();
    return "$hour:$minute $period";
  }

  // Fetch user profile from Firestore
  Future<Map<String, dynamic>> _getUserProfile(String receiverId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return {
          'name': userData['name'] ?? 'Unknown',
          'profileImage': userData['profileImage'] ??
              'https://example.com/default_profile.png', // Fallback image
        };
      } else {
        return {
          'name': 'Unknown',
          'profileImage': 'https://example.com/default_profile.png', // Fallback image
        };
      }
    } catch (e) {
      return {
        'name': 'Unknown',
        'profileImage': 'https://example.com/default_profile.png', // Fallback image
      };
    }
  }
}
