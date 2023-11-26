import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_doctor_schedule_app/constants/navigation_widget.dart';
import 'package:patient_doctor_schedule_app/screen/chat_messages/chat_screen.dart';

import '../constants/app_style.dart';
import '../constants/textstyle.dart';
import '../controller/model/appointment_controller/booking_model.dart';

class AppointmentDetails extends StatelessWidget {
  final Bookings bookings;
  const AppointmentDetails({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    int startMinutes = bookings.startTime.hour * 60 + bookings.startTime.minute;
    int endMinutes = bookings.endTime.hour * 60 + bookings.endTime.minute;

    int differenceInMinutes = endMinutes - startMinutes;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.information_circle,
                color: AppColor.backColor(),
              ))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Appointment',
          style: textStyle(
              size: 24, weight: FontWeight.w600, color: AppColor.backColor()),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        boxShadow: const [BoxShadow(color: Colors.white)],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        const Color.fromRGBO(199, 192, 192, 1)),
                                child: Image.asset(
                                  bookings.doctor.image,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bookings.doctor.name,
                                    style: textStyle(
                                        size: 20,
                                        weight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Divider(
                                      thickness: 1,
                                      color: Color.fromARGB(238, 238, 238, 1),
                                    ),
                                  ),
                                  Text(
                                    bookings.doctor.specialist,
                                    style: textStyle(
                                        size: 14,
                                        weight: FontWeight.w600,
                                        color: AppColor.bgColor()),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    bookings.doctor.hospital,
                                    style: textStyle(
                                        size: 14,
                                        weight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Scheduled Appointment',
                      style: textStyle(
                          size: 18,
                          weight: FontWeight.w600,
                          color: AppColor.backColor()),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      DateFormat.yMMMEd().format(bookings.date),
                      style: textStyle(
                          size: 14,
                          weight: FontWeight.w400,
                          color: const Color.fromRGBO(66, 66, 66, 1)),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          "${bookings.startTime.format(context)}-${bookings.endTime.format(context)}",
                          style: textStyle(
                              size: 13,
                              weight: FontWeight.w500,
                              color: const Color.fromRGBO(66, 66, 66, 1)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "($differenceInMinutes mins)",
                          style: textStyle(
                              size: 13,
                              weight: FontWeight.w500,
                              color: const Color.fromRGBO(66, 66, 66, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Personnal Information',
                      style: textStyle(
                          size: 18,
                          weight: FontWeight.w600,
                          color: AppColor.backColor()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        buildInformationWidget(
                            title: 'Full Name', subtititle: bookings.name),
                        const SizedBox(
                          height: 8,
                        ),
                        buildInformationWidget(
                            title: 'Gender', subtititle: bookings.gender),
                        const SizedBox(
                          height: 8,
                        ),
                        buildInformationWidget(
                            title: 'Age', subtititle: bookings.age),
                        const SizedBox(
                          height: 8,
                        ),
                        IntrinsicHeight(
                            child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 80,
                              child: Text('Problem',
                                  style: textStyle(
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: AppColor.bgColor())),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const VerticalDivider(),
                                  Expanded(
                                    child: Text(bookings.problems,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle(
                                            size: 13,
                                            weight: FontWeight.w500,
                                            color: const Color.fromRGBO(
                                                66, 66, 66, 1))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Your Packaging',
                      style: textStyle(
                          size: 18,
                          weight: FontWeight.w600,
                          color: AppColor.backColor()),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColor.bgColor(),
                          child: const Icon(
                            Ionicons.chatbox,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Messaging!',
                                      style: textStyle(
                                          size: 16,
                                          weight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'chat with doctor',
                                      style: textStyle(
                                          size: 14,
                                          weight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                  ]),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.bgColor()),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Text(
                                    '\$20',
                                    style: textStyle(
                                        size: 14,
                                        weight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bookings.isComplete == true
                ? SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColor.backColor(),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Appointment Completed',
                          style: textStyle(
                              size: 18,
                              weight: FontWeight.w500,
                              color: Colors.white),
                        )),
                  )
                : (bookings.isCancelled == true
                    ? SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Appointment Cancelled',
                              style: textStyle(
                                  size: 18,
                                  weight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      )
                    : NavigationWidget(
                        tap: () {
                          Get.to(() => ChatScreen(doctor: bookings));
                        },
                        title:
                            'Message start (${bookings.startTime.format(context)})',
                      ))
          ],
        ),
      ),
    );
  }

  IntrinsicHeight buildInformationWidget({
    required String title,
    required String subtititle,
  }) {
    return IntrinsicHeight(
        child: Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(title,
              style: textStyle(
                  size: 14,
                  weight: FontWeight.w500,
                  color: AppColor.bgColor())),
        ),
        Row(
          children: [
            const VerticalDivider(),
            Text(subtititle,
                style: textStyle(
                    size: 13,
                    weight: FontWeight.w500,
                    color: const Color.fromRGBO(66, 66, 66, 1))),
          ],
        ),
      ],
    ));
  }
}
