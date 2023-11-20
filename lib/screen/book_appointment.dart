import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/app_style.dart';
import '../constants/navigation_widget.dart';
import '../constants/textstyle.dart';
import '../controller/model/doctor_controller.dart/doctor_model.dart';
import 'patient_details.dart';

class BookAppointment extends StatefulWidget {
  final Doctors doctor;
  const BookAppointment({super.key, required this.doctor});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _selectedDay = now;
  }

  late WorkingHour selectedHour;

  int selectedHourIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Book Appointment',
            style: textStyle(
                size: 24, weight: FontWeight.w600, color: AppColor.backColor()),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        'Select Date',
                        style: textStyle(
                            size: 22,
                            weight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: const Color.fromRGBO(123, 193, 183, 0.1)),
                        child: TableCalendar(
                          daysOfWeekStyle: const DaysOfWeekStyle(
                              weekdayStyle: TextStyle(color: Colors.black)),
                          headerStyle: HeaderStyle(
                            titleTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                                color: AppColor.bgColor(),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            formatButtonTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 16.0),
                            formatButtonDecoration: BoxDecoration(
                              color: AppColor.backColor(),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            leftChevronIcon: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 28,
                            ),
                            rightChevronIcon: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.bgColor()),
                              selectedTextStyle: const TextStyle(
                                color: Colors.white,
                              )),
                          firstDay: DateTime.utc(2022, 10, 16),
                          lastDay: DateTime.utc(2033, 3, 14),
                          focusedDay: DateTime.now(),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select Hour',
                        style: textStyle(
                            size: 22,
                            weight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children:
                            widget.doctor.workingHours.asMap().entries.map((e) {
                          final int index = e.key;
                          final WorkingHour hour = e.value;

                          // Determine if the current hour is selected
                          final bool isSelected = selectedHourIndex == index;
                          return OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: AppColor.backColor(),
                              ),
                              backgroundColor:
                                  isSelected ? AppColor.bgColor() : null,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedHourIndex = isSelected ? -1 : index;
                              });
                            },
                            child: Text(
                              "${hour.startTime.format(context)} - ${hour.endTime.format(context)}",
                              style: textStyle(
                                size: 12,
                                weight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : AppColor.bgColor(),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ])),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: NavigationWidget(
                  title: 'Next',
                  tap: () {
                    if (selectedHourIndex != -1) {
                      // Check if an hour is selected
                      selectedHour =
                          widget.doctor.workingHours[selectedHourIndex];
                      Get.to(() => PatientDetails(
                            date: _selectedDay,
                            time: selectedHour, doctor:widget.doctor,
                          ));
                    } else {
                      // Show an alert or message if no hour is selected
                      // Example:
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please select an hour.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
