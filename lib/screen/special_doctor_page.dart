import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_doctor_schedule_app/screen/doctor_details.dart';

import '../constants/app_style.dart';
import '../constants/search_widget.dart';
import '../constants/textstyle.dart';
import '../controller/model/doctor_controller.dart/doctor_model.dart';
import 'book_appointment.dart';

class SpecialistPage extends StatefulWidget {
  final DoctorCategory category;
  const SpecialistPage({super.key, required this.category});

  @override
  State<SpecialistPage> createState() => _SpecialistPageState();
}

class _SpecialistPageState extends State<SpecialistPage> {
  final searchController = TextEditingController();
  late List<Doctors> filteredDoctors = [];
  bool foundDoctor = false;

  @override
  void initState() {
    super.initState();
    filterDoctors('');
  }

  void filterDoctors(String query) {
    final String specialist = widget.category.specialist;
    filteredDoctors = doctorList
        .where((doctor) =>
            doctor.specialist == specialist &&
            doctor.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      foundDoctor = filteredDoctors.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String specialist = widget.category.specialist;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          specialist,
          style: textStyle(
              size: 24, weight: FontWeight.w600, color: AppColor.backColor()),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchWidget(
              prefix: 'Search a Doctor',
              trailingIcon: Icons.mic,
              onChanged: (String value) {
                filterDoctors(value);
              },
              search: searchController,
            ),
            const SizedBox(
              height: 15,
            ),
            foundDoctor
                ? Center(
                    child: Text(
                      'Doctors not Found',
                      style: textStyle(
                          size: 24,
                          weight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: filteredDoctors.length,
                        itemBuilder: (context, index) {
                          final items = filteredDoctors[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => DoctorDetails(doctors: items));
                            },
                            child: Container(
                              height: 205,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(210, 235, 231, 0.3),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    items.image,
                                    width: 150,
                                    height: 150,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              items.name,
                                              style: textStyle(
                                                  size: 18,
                                                  weight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      items.favorite =
                                                          !items.favorite;
                                                    });
                                                  },
                                                  icon: Icon(
                                                      items.favorite
                                                          ? Icons
                                                              .favorite_border_outlined
                                                          : Icons.favorite,
                                                      color: items.favorite
                                                          ? AppColor.bgColor()
                                                          : AppColor
                                                              .backColor())),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Text(
                                            items.description,
                                            style: textStyle(
                                                    size: 12,
                                                    weight: FontWeight.w400,
                                                    color: Colors.grey)
                                                .copyWith(
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => BookAppointment(
                                                    doctor: items));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.backColor(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0,
                                                          left: 15,
                                                          top: 8,
                                                          bottom: 8),
                                                  child: Text(
                                                    'Book',
                                                    style: textStyle(
                                                        size: 14,
                                                        weight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Ionicons.star,
                                                  color: Colors.orange,
                                                ),
                                                const SizedBox(width: 8),
                                                Text('5.0',
                                                    style: textStyle(
                                                        size: 16,
                                                        weight: FontWeight.w600,
                                                        color: Colors.black))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
