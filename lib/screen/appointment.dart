 
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/app_style.dart';
import '../constants/cancel_appoint.dart';
import '../constants/completed_appoint.dart';
import '../constants/textstyle.dart';
import '../constants/upcoming_page.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Ionicons.search,
                  color: AppColor.backColor(),
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Ionicons.chatbox,
                  color: AppColor.backColor(),
                )),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Appointment',
            style: textStyle(
                size: 24, weight: FontWeight.w600, color: AppColor.backColor()),
          ),
          bottom: TabBar(
            indicatorColor: AppColor.backColor(),
            labelColor: AppColor.backColor(),
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            UpComingAppointment(),
            CompletedAppointment(),
            CancelAppointment(),
          ],
        ),
      ),
    );
  }
}
