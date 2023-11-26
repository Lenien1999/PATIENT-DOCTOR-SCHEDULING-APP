import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_doctor_schedule_app/auth/auth_controller/authcontroller.dart';
import 'package:patient_doctor_schedule_app/constants/text_field.dart';
import 'package:patient_doctor_schedule_app/screen/chat_messages/chat_model.dart';
import 'package:patient_doctor_schedule_app/screen/chat_messages/chat_service.dart';
import '../../auth/auth_controller/auth_model.dart';
import '../../constants/app_style.dart';
import '../../constants/textstyle.dart';
import '../../controller/model/appointment_controller/booking_model.dart';
import '../../db_manager/user_controller.dart';

class ChatScreen extends StatefulWidget {
  final Bookings doctor;
  const ChatScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserModel? _userData;
  final user = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    await _fetchUserData(user.fireBaseUser.value!.uid);
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      FirebaseMethods firebaseMethods = FirebaseMethods();
      UserModel? userData = await firebaseMethods.getUserData(userId);
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  final messageController = TextEditingController();
  final chatService = Get.put(ChatService());

  void sendMessages() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.doctor.doctor.id ?? '', messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_bubble),
            color: AppColor.backColor(),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.doctor.doctor.name,
          style: textStyle(
            size: 24,
            weight: FontWeight.w600,
            color: AppColor.backColor(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Messages>>(
      stream: chatService.getListMessages(
          user.fireBaseUser.value!.uid, widget.doctor.doctor.id ?? ''),
      builder: (context, AsyncSnapshot<List<Messages>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildMessageListItem(
                snapshot.data![index],
              );
            },
          );
        }
      },
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextFielWidget(
            controller: messageController,
            validator: (value) {},
            icon: Icons.messenger,
            title: 'Type...',
            isTrailing: false,
          ),
        ),
        IconButton(
          onPressed: sendMessages,
          icon: Icon(
            Icons.send,
            size: 40,
          ),
        ),
      ],
    );
  }

  Widget _buildMessageListItem(
    Messages document,
  ) {
    bool isSentByUser = document.senderId == user.fireBaseUser.value!.uid;
    return Container(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment:
            isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: document.messages,
            user: _userData?.fullName ?? "Your Name",
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String user;
  const ChatBubble({Key? key, required this.message, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.teal, // Customize the bubble color here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user,
            style: textStyle(
              size: 16,
              weight: FontWeight.w400,
              color: Colors.white, // Customize the text color here
            ),
          ),
          Text(
            message,
            style: textStyle(
              size: 16,
              weight: FontWeight.w400,
              color: Colors.white, // Customize the text color here
            ),
          ),
        ],
      ),
    );
  }
}
