import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_doctor_schedule_app/auth/auth_controller/authcontroller.dart';
import 'package:patient_doctor_schedule_app/screen/chat_messages/chat_model.dart';
import 'package:get/get.dart';

final userController = Get.put(AuthController());

class ChatService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('chat_room');

  Future<void> sendMessage(String receiveId, String message) async {
    final String currentUserId = userController.fireBaseUser.value!.uid;
    final String currentUserEmail =
        userController.fireBaseUser.value!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    Messages newMessage = Messages(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiveId,
      messages: message,
      timestamp: timestamp,
    );
    List<String> ids = [receiveId, currentUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _collectionReference
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  Stream<List<Messages>> getListMessages(String userId, String otherUser) {
    List<String> ids = [userId, otherUser];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _collectionReference
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Messages.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
