import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:patient_doctor_schedule_app/controller/model/appointment_controller/booking_model.dart';
import 'package:patient_doctor_schedule_app/db_manager/appointment_controller.dart';
import 'package:patient_doctor_schedule_app/screen/book_appointment.dart';

import '../screen/appointment_details.dart';
import 'app_style.dart';
import 'textstyle.dart';

class CompletedAppointment extends StatelessWidget {
  const CompletedAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final complete = Get.put(BookingController());
    return StreamBuilder<List<Bookings>>(
        stream: complete.completeappointmentList(),
        builder: (context, snapshot) {
          List<Bookings>? completeBooking = snapshot.data;
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
                'No Complete Appointment',
                style: textStyle(
                    size: 24, weight: FontWeight.w600, color: Colors.black),
              ),
            );
          }
          return ListView.builder(
              itemCount: completeBooking!.length,
              itemBuilder: (context, index) {
                final complete = completeBooking[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => AppointmentDetails(bookings: complete));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color.fromARGB(
                                            255, 140, 196, 187)),
                                    child: Image.asset(
                                      complete.doctor.image,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Flexible(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      complete.doctor.name,
                                      style: textStyle(
                                          size: 24,
                                          weight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Messaging--',
                                          style: textStyle(
                                              size: 13,
                                              weight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 25,
                                          child: OutlinedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                side: BorderSide(
                                                    color: AppColor.bgColor())),
                                            onPressed: () {},
                                            child: Text(
                                              'completed',
                                              style: textStyle(
                                                  size: 10,
                                                  weight: FontWeight.w600,
                                                  color: AppColor.bgColor()),
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
                                          DateFormat.yMMMd()
                                              .format(complete.date),
                                          style: textStyle(
                                              size: 13,
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
                                          "${complete.startTime.format(context)}- ${complete.endTime.format(context)}",
                                          style: textStyle(
                                              size: 13,
                                              weight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.3),
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        side: BorderSide(
                                            color: AppColor.bgColor())),
                                    onPressed: () {
                                      Get.to(() => BookAppointment(
                                          doctor: complete.doctor));
                                    },
                                    child: Text(
                                      'Book Again',
                                      style: textStyle(
                                          size: 13,
                                          weight: FontWeight.w600,
                                          color: AppColor.bgColor()),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.backColor(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Leave a review',
                                      style: textStyle(
                                          size: 13,
                                          weight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
