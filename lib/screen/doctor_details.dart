import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_doctor_schedule_app/screen/book_appointment.dart';

import '../constants/app_style.dart';
import '../constants/navigation_widget.dart';
import '../constants/textstyle.dart';
import '../controller/model/doctor_controller.dart/doctor_model.dart';

class DoctorDetails extends StatelessWidget {
  final Doctors doctors;
  const DoctorDetails({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          doctors.name,
          style: textStyle(
              size: 24, weight: FontWeight.w600, color: AppColor.backColor()),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
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
                                  doctors.image,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  doctors.name,
                                  style: textStyle(
                                      size: 24,
                                      weight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  height: 2,
                                  thickness: 3,
                                ),
                                Text(
                                  doctors.specialist,
                                  style: textStyle(
                                      size: 14,
                                      weight: FontWeight.w600,
                                      color: AppColor.bgColor()),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  doctors.hospital,
                                  style: textStyle(
                                      size: 15,
                                      weight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildDoctorsBookItem(
                            icon: Ionicons.person_add,
                            title: '12 +',
                            subtitle: 'Patients'),
                        buildDoctorsBookItem(
                            icon: Ionicons.star_half,
                            subtitle: 'Rating',
                            title: '4.8'),
                        buildDoctorsBookItem(
                            icon: Ionicons.chatbox,
                            subtitle: '3,44',
                            title: 'Reviews'),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'About Me',
                      style: textStyle(
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      doctors.aboutMe,
                      style: textStyle(
                          size: 12,
                          weight: FontWeight.w400,
                          color: const Color.fromRGBO(66, 66, 66, 1)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Working Hours',
                      style: textStyle(
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      'Monday - Friday, 08.00 AM - 20.00 PM',
                      style: textStyle(
                          size: 12,
                          weight: FontWeight.w400,
                          color: const Color.fromRGBO(66, 66, 66, 1)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Review',
                          style: textStyle(
                              size: 24,
                              weight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(() => const DoctorsPage());
                          },
                          child: Text(
                            'See All',
                            style: textStyle(
                                size: 16,
                                weight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      shadowColor: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                        'assets/images/profile.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Olaitan olawale',
                                      style: textStyle(
                                          size: 18,
                                          weight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Ionicons.chatbox,
                                      color: AppColor.backColor(),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                    itemCount: 5,
                                    itemSize: 20,
                                    initialRating: 4,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      );
                                    },
                                    onRatingUpdate: (rating) {}),
                                const SizedBox(width: 10),
                                Text(
                                  '4.5',
                                  style: textStyle(
                                      size: 18,
                                      weight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              doctors.description,
                              style: textStyle(
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationWidget(
                title: 'Book Appointment',
                tap: () {
                  Get.to(() => BookAppointment(
                        doctor: doctors,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildDoctorsBookItem(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 248, 252, 248),
          radius: 30,
          child: Icon(
            icon,
            size: 30,
            color: AppColor.backColor(),
          ),
        ),
        Text(
          title,
          style: textStyle(
              size: 18, weight: FontWeight.w600, color: AppColor.backColor()),
        ),
        Text(
          subtitle,
          style:
              textStyle(size: 14, weight: FontWeight.w600, color: Colors.grey),
        ),
      ],
    );
  }
}
