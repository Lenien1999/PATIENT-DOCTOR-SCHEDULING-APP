import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_doctor_schedule_app/controller/model/appointment_controller/booking_model.dart';
import 'package:patient_doctor_schedule_app/db_manager/appointment_controller.dart';
import 'package:patient_doctor_schedule_app/screen/appointment_details.dart';

import 'app_style.dart';
import 'textstyle.dart';

class CancelAppointment extends StatelessWidget {
  const CancelAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final cancel = Get.put(BookingController());
    return StreamBuilder<List<Bookings>>(
        stream: cancel.cancelappointmentList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Cancel Appointment',
                style: textStyle(
                    size: 24, weight: FontWeight.w600, color: Colors.black),
              ),
            );
          }
          List<Bookings> cancelBooking = snapshot.data!;

          return ListView.builder(
              itemCount: cancelBooking.length,
              itemBuilder: ((context, index) {
                final cancelled = cancelBooking[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => AppointmentDetails(bookings: cancelled));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color.fromARGB(
                                            255, 140, 196, 187)),
                                    child: Image.asset(
                                      cancelled.doctor.image,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cancelled.doctor.name,
                                    style: textStyle(
                                        size: 18,
                                        weight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Messaging--',
                                        style: textStyle(
                                            size: 12,
                                            weight: FontWeight.w600,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: OutlinedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(0),
                                              side: const BorderSide(
                                                  color: Colors.redAccent)),
                                          onPressed: () {},
                                          child: Text(
                                            'Cancelled',
                                            style: textStyle(
                                                size: 10,
                                                weight: FontWeight.w600,
                                                color: Colors.redAccent),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat.yMMMEd()
                                            .format(cancelled.date),
                                        style: textStyle(
                                            size: 12,
                                            weight: FontWeight.w600,
                                            color: Colors.grey),
                                      ),
                                      Container(
                                        width: 1, // Width of the divider line
                                        height:
                                            13, // Height of the divider line
                                        color: Colors
                                            .grey, // Color of the divider line
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                      ),
                                      Text(
                                        cancelled.startTime.format(context),
                                        style: textStyle(
                                            size: 12,
                                            weight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 217, 223, 222),
                                radius: 30,
                                child: Icon(
                                  Ionicons.chatbox_ellipses,
                                  color: AppColor.backColor(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
  }
}
