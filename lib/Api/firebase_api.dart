import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:patient_doctor_schedule_app/constants/bottombar_navigation.dart';

Future<void> handleBackgroudMessage(RemoteMessage message) async {
  print("Message ${message.category}");
}

class FirebaseApi {
  final _firbaseMessaging = FirebaseMessaging.instance;
  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    } else {
      Get.to(() => BottomNavigation());
    }
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroudMessage);
  }

  Future<void> initNotification() async {
    await _firbaseMessaging.requestPermission();
    final fcmToken = await _firbaseMessaging.getToken();
    print(fcmToken);
    initPushNotification();
  }
}
