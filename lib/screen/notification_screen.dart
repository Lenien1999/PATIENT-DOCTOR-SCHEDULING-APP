import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_doctor_schedule_app/controller/model/appointment_controller/booking_model.dart';
import 'package:patient_doctor_schedule_app/db_manager/appointment_controller.dart';
import '../constants/app_style.dart';
import '../constants/search_widget.dart';
import '../constants/textstyle.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<IconData> availableIcons = [
    Icons.notification_add,
    Ionicons.notifications_circle,
    Ionicons.notifications_sharp,
    Icons.notifications,
    // Add more icons as needed
  ];

  IconData getRandomIcon() {
    int randomIndex = Random().nextInt(availableIcons.length);

    return availableIcons[randomIndex];
  }

  final notificationSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.chatbox,
                color: AppColor.backColor(),
              ))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Notification',
          style: textStyle(
              size: 24, weight: FontWeight.w600, color: AppColor.backColor()),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          SearchWidget(
            onChanged: (String quary) {},
            prefix: 'Search..',
            trailingIcon: Ionicons.notifications,
            search: notificationSearch,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: StreamBuilder<List<Bookings>>(
                stream: notificationController.appointmentList(),
                builder: ((context, snapshot) {
                  List<Bookings>? notification = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Notification'),
                    );
                  }
                  return ListView.builder(
                      itemCount: notification!.length,
                      itemBuilder: ((context, index) {
                        final notice = notification[index];
                        return Container(
                          padding: EdgeInsets.all(15),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: Colors.white)
                              ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    child: Icon(
                                      getRandomIcon(),
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                notice.isCancelled
                                                    ? 'Appointment Cancelled!'
                                                    : (notice.isComplete
                                                        ? 'Appointment Completed!'
                                                        : 'Appointment Success!'),
                                                style: textStyle(
                                                  size: 16,
                                                  weight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    DateFormat.yMMMEd().format(
                                                        notice
                                                            .cancellationTimestamp!),
                                                    style: textStyle(
                                                        size: 14,
                                                        weight: FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                  Container(
                                                    width:
                                                        1, // Width of the divider line
                                                    height:
                                                        13, // Height of the divider line
                                                    color: Colors
                                                        .grey, // Color of the divider line
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                  ),
                                                  Text(
                                                    DateFormat.jm().format(notice
                                                        .cancellationTimestamp!),
                                                    style: textStyle(
                                                        size: 14,
                                                        weight: FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //       color: AppColor.bgColor()),
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 8, vertical: 5),
                                        //     child: Text(
                                        //       'New',
                                        //       style: textStyle(
                                        //           size: 14,
                                        //           weight: FontWeight.w600,
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              notice.isCancelled
                                  ? Text(
                                      'You have successfully cancelled your appointment with ${notice.doctor.name} on ${DateFormat.yMMMEd().format(notice.date)}, ${notice.startTime.format(context)}-${notice.endTime.format(context)} 80% of the funds will be returned to your account.',
                                      style: textStyle(
                                          size: 12,
                                          weight: FontWeight.w500,
                                          color: Colors.grey.shade500),
                                    )
                                  : notice.isComplete
                                      ? Text(
                                          'You have successfully Completed your appointment with ${notice.doctor.name} on ${DateFormat.yMMMEd().format(notice.date)}, ${notice.startTime.format(context)}-${notice.endTime.format(context)}.',
                                          style: textStyle(
                                              size: 12,
                                              weight: FontWeight.w500,
                                              color: Colors.grey.shade500),
                                        )
                                      : Text(
                                          "You have successfully booked an appointment with ${notice.doctor.name} on ${DateFormat.yMMMEd().format(notice.date)}, ${notice.startTime.format(context)}-${notice.endTime.format(context)}.Don't forget to activate your reminder.",
                                          style: textStyle(
                                              size: 12,
                                              weight: FontWeight.w500,
                                              color: Colors.grey.shade500),
                                        ),
                            ],
                          ),
                        );
                      }));
                })),
          )
        ]),
      ),
    );
  }
}
