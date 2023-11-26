import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String messages;
  final Timestamp timestamp;

  Messages(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.messages,
      required this.timestamp});
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'messages': messages,
      'timestamp': timestamp
    };
  }

  factory Messages.fromJson(Map<String, dynamic> data) {
    return Messages(
        senderId: data["senderId"] ?? "",
        senderEmail: data["senderEmail"] ?? "",
        receiverId: data["receiverId"] ?? '',
        messages: data["messages"] ?? '',
        timestamp: data['timestamp'] ?? '');
  }
}
