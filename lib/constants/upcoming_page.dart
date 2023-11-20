import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patient_doctor_schedule_app/screen/appointment_details.dart';
import '../controller/model/appointment_controller/booking_model.dart';
import '../db_manager/appointment_controller.dart';
import '../screen/book_appointment.dart';
import 'app_style.dart';
import 'textstyle.dart';

class UpComingAppointment extends StatefulWidget {
  const UpComingAppointment({super.key});

  @override
  State<UpComingAppointment> createState() => _UpComingAppointmentState();
}

class _UpComingAppointmentState extends State<UpComingAppointment> {
  @override
  Widget build(BuildContext context) {
    final appointmentController = Get.put(BookingController());
    return StreamBuilder<List<Bookings>>(
        stream: appointmentController.appointmentList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Upcoming Appointments',
                style: textStyle(
                    size: 24, weight: FontWeight.w600, color: Colors.black),
              ),
            );
          } else {
            List<Bookings> appointments = snapshot.data!;

            // Filter out completed appointments

            List<Bookings> upcomingAppointments = appointments
                .where((appointment) =>
                    !appointment.isComplete && !appointment.isCancelled)
                .toList();

            return ListView.builder(
                itemCount: upcomingAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = upcomingAppointments[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => AppointmentDetails(
                            bookings: appointment,
                          ));
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: const Color.fromARGB(
                                              255, 140, 196, 187)),
                                      child: Image.asset(
                                        appointment.doctor.image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      appointment.doctor.name,
                                      style: textStyle(
                                          size: 24,
                                          weight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Messaging-',
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
                                              'upcoming',
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
                                              .format(appointment.date),
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
                                          "${appointment.startTime.format(context)}-${appointment.endTime.format(context)}",
                                          style: textStyle(
                                              size: 13,
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
                                  radius: 25,
                                  child: Checkbox(
                                    activeColor: Colors.teal,
                                    value: appointment.isComplete,
                                    onChanged: (newValue) {
                                      appointment.isComplete = newValue!;
                                      appointmentController
                                          .markTaskAsComplete(appointment);
                                    },
                                  ),
                                )
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
                                SizedBox(
                                  height: 35,
                                  child: OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        side: BorderSide(
                                            color: AppColor.bgColor())),
                                    onPressed: () async {
                                      setState(() {
                                        appointment.isCancelled = true;
                                        appointmentController
                                            .markTaskAsCancelled(appointment);
                                        // Move to cancel screen
                                      });
                                    },
                                    child: Text(
                                      'Cancel Appointment',
                                      style: textStyle(
                                          size: 13,
                                          weight: FontWeight.w600,
                                          color: AppColor.bgColor()),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.backColor(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                    ),
                                    onPressed: () {
                                      Get.to(() {
                                        return BookAppointment(
                                          doctor: appointment.doctor,
                                        );
                                      });
                                    },
                                    child: Text(
                                      'Reschedule Appointment',
                                      style: textStyle(
                                          size: 13,
                                          weight: FontWeight.w600,
                                          color: Colors.white),
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
          }
        });
  }
}
