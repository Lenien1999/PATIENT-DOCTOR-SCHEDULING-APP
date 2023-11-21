import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:patient_doctor_schedule_app/auth/auth_controller/auth_model.dart';
import 'package:patient_doctor_schedule_app/auth/auth_controller/authcontroller.dart';
import 'package:patient_doctor_schedule_app/constants/app_style.dart';
import 'package:patient_doctor_schedule_app/constants/bottombar_navigation.dart';
import 'package:patient_doctor_schedule_app/constants/navigation_widget.dart';
import 'package:patient_doctor_schedule_app/controller/model/appointment_controller/booking_model.dart';
import 'package:patient_doctor_schedule_app/controller/model/doctor_controller.dart/doctor_model.dart';
import 'package:patient_doctor_schedule_app/db_manager/appointment_controller.dart';
import 'package:patient_doctor_schedule_app/db_manager/user_controller.dart';

import '../constants/textstyle.dart';

class PatientDetails extends StatefulWidget {
  final DateTime date;
  final Doctors doctor;
  final WorkingHour time;
  const PatientDetails(
      {super.key,
      required this.date,
      required this.time,
      required this.doctor});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final bookingcontroller = Get.put(BookingController());
  final controller = Get.put(AuthController());
  String selectedValue = 'Male'; // Default selected value

  List<String> dropdownItems = [
    'Male',
    'Female',
  ];

  UserModel? _userData;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    await _fetchUserData(controller.fireBaseUser.value!.uid);
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

  final problem = TextEditingController();
  final age = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final fullName = TextEditingController(
      text: _userData?.fullName ?? 'Loading...',
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Patient Details',
          style: textStyle(
              size: 24, weight: FontWeight.w500, color: AppColor.backColor()),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Full Name',
                        style: textStyle(
                            size: 22,
                            weight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextFormField(
                        controller: fullName,
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Ionicons.person_add,
                              color: AppColor.bgColor(),
                            ),
                            hintText: 'Full Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Gender',
                        style: textStyle(
                            size: 22,
                            weight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          fillColor: Colors.grey.withOpacity(0.1),
                          prefixIcon: Icon(
                            Ionicons.people_circle,
                            color: AppColor.bgColor(),
                          ),
                        ),
                        value: selectedValue,
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Your Age',
                        style: textStyle(
                            size: 22,
                            weight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Age';
                          }
                          return null; // Return null if the input is valid
                        },
                        controller: age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Ionicons.grid_outline,
                              color: AppColor.bgColor(),
                            ),
                            hintText: 'Age',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Write Your Problem',
                        style: textStyle(
                            size: 22,
                            weight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextFormField(
                        controller: problem,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your problem';
                          }
                          return null; // Return null if the input is valid
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationWidget(
                title: 'Next',
                tap: () async {
                  Bookings booking = Bookings(
                      userId: controller.fireBaseUser.value!.uid,
                      age: age.text,
                      date: widget.date,
                      gender: selectedValue,
                      name: fullName.text,
                      problems: problem.text,
                      startTime: widget.time.startTime,
                      endTime: widget.time.endTime,
                      isComplete: false,
                      doctor: widget.doctor);

                  if (_key.currentState!.validate()) {
                    await bookingcontroller
                        .bookAppointment(booking)
                        .whenComplete(
                          () => showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(const Duration(seconds: 3), () {
                                  // Task completed, close the dialog
                                  Navigator.of(context).pop();
                                  // Navigate to another page (e.g., LoginScreen)
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const BottomNavigation();
                                  }));
                                });
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 400,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/dne.png',
                                          color: AppColor.bgColor(),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Congratulations!',
                                          style: textStyle(
                                              size: 20,
                                              weight: FontWeight.w500,
                                              color: AppColor.backColor()),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Appointment successfully booked. You will receive a notification and the doctor you selected will contact you..',
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              size: 16,
                                              weight: FontWeight.w500,
                                              color: const Color.fromRGBO(
                                                  33, 33, 33, 1)),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                  }
                  // Get.to(() => const PatientDetails());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
