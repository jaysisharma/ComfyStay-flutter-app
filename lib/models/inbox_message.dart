import 'package:cloud_firestore/cloud_firestore.dart';

class InboxMessage {
  final String userId;
  final String propertyId;
  final String message;
  final Timestamp timestamp;

  InboxMessage({
    required this.userId,
    required this.propertyId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'propertyId': propertyId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory InboxMessage.fromMap(Map<String, dynamic> map) {
    return InboxMessage(
      userId: map['userId'] ?? '',
      propertyId: map['propertyId'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
