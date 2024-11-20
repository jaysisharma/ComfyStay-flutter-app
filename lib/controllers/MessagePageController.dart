import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagePageController extends GetxController {
  // Reactive variables
  var userName = ''.obs;
  var profileImage = ''.obs;
  var isLoading = true.obs;  // Loading state for the user profile
  var messages = <Map<String, dynamic>>[].obs;

  // Fetch user profile data
  Future<void> fetchUserProfile(String userId) async {
    isLoading.value = true;
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        userName.value = userData['name'] ?? 'Unknown';
        profileImage.value = userData['profileImage'] ?? 'https://example.com/default_profile.png';
      } else {
        userName.value = 'Unknown';
        profileImage.value = 'https://example.com/default_profile.png';
      }
    } catch (e) {
      userName.value = 'Unknown';
      profileImage.value = 'https://example.com/default_profile.png';
    }
    isLoading.value = false;
  }

  // Fetch messages in real-time
  Stream<List<Map<String, dynamic>>> getMessages(String userId, String receiverId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(userId + '-' + receiverId)
        .collection('chatMessages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
              'senderId': doc['senderId'],
              'receiverId': doc['receiverId'],
              'message': doc['message'],
              'timestamp': doc['timestamp'],
              'status': doc['status'],
            }).toList());
  }

  // Send a message
  Future<void> sendMessage(String userId, String receiverId, String message) async {
    if (message.isNotEmpty) {
      try {
        var timestamp = FieldValue.serverTimestamp();
        await FirebaseFirestore.instance.collection('messages')
            .doc(userId + '-' + receiverId)
            .collection('chatMessages')
            .add({
          'senderId': userId,
          'receiverId': receiverId,
          'message': message,
          'timestamp': timestamp,
          'status': 'sent', // Initial status
        });
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }
}
