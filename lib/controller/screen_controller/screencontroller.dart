 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen/appointment.dart';
import '../../screen/home_page.dart';
import '../../screen/notification_screen.dart';
import '../../screen/profile_page.dart';


class ScreenController extends GetxController {
  int pageIndex = 0;
    List<Widget> pageList = [
    const HomeScreen(),
    const Appointment(),
    const NotificationScreen(),
    const ProfilePage(),
  ];

  void pageChange(int index) {
    pageIndex = index;
    update();
  }
}
