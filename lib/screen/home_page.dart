import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../auth/auth_controller/auth_model.dart';
import '../auth/auth_controller/authcontroller.dart';
import '../constants/app_style.dart';
import '../constants/carousel_model.dart';
import '../constants/carousel_slider.dart';
import '../constants/textstyle.dart';
import '../controller/model/doctor_controller.dart/doctor_model.dart';
import '../db_manager/user_controller.dart';
import 'book_appointment.dart';
import 'doctor_details.dart';
import 'doctors_page.dart';
import 'special_doctor_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final search = TextEditingController();
  final CarouselController _controller = CarouselController();
  int currentPage = 0;
  final controller = Get.put(AuthController());

  UserModel? _userData;
  bool isPress = false;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ignore: unnecessary_null_comparison
        body: controller.fireBaseUser.value!.uid == null
            ? const CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child:
                                      Image.asset('assets/images/profile.png'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, Welcome Back',
                                    style: textStyle(
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: const Color.fromRGBO(
                                            133, 133, 133, 1)),
                                  ),
                                  Text(
                                    _userData?.fullName ?? 'Loading...',
                                    style: textStyle(
                                        size: 16,
                                        weight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Ionicons.notifications_outline,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: search,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: const Icon(Ionicons.search),
                              hintText: 'Seacrh a doctor',
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.mic)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CarouselSlider.builder(
                        carouselController: _controller,
                        itemCount: carouselList.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          final item = carouselList[itemIndex];
                          return CarouselSliderWidget(item: item);
                        },
                        options: CarouselOptions(
                            height: 155,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            onPageChanged: (val, _) {
                              setState(() {
                                currentPage = val;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CarouselDot(
                          controller: _controller, currentPage: currentPage),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: textStyle(
                                size: 24,
                                weight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            'All',
                            style: textStyle(
                                size: 16,
                                weight: FontWeight.w400,
                                color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              doctorCartegoryList.asMap().entries.map((entry) {
                            final DoctorCategory e = entry.value;

                            return InkWell(
                              onTap: () {
                                Get.to(() {
                                  return SpecialistPage(
                                    category: e,
                                  );
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: AppColor.bgColor(),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Center(
                                  child: Text(
                                    e.specialist,
                                    style: textStyle(
                                        size: 20,
                                        weight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Doctors',
                            style: textStyle(
                                size: 24,
                                weight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const DoctorsPage());
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
                      SizedBox(
                        height: 230,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: doctorList.length.clamp(1, 4),
                            itemBuilder: (context, index) {
                              final items = doctorList[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() {
                                    return DoctorDetails(
                                      doctors: items,
                                    );
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        210, 235, 231, 0.3),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        items.image,
                                        width: 150,
                                        height: 150,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  items.name,
                                                  style: textStyle(
                                                      size: 18,
                                                      weight: FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isPress = !isPress;
                                                      });
                                                    },
                                                    icon: Icon(
                                                        isPress
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_outlined,
                                                        color: isPress
                                                            ? AppColor.bgColor()
                                                            : AppColor
                                                                .backColor()))
                                              ],
                                            ),
                                            Text(
                                              items.description,
                                              style: textStyle(
                                                      size: 12,
                                                      weight: FontWeight.w400,
                                                      color: Colors.grey)
                                                  .copyWith(
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(() {
                                                      return BookAppointment(
                                                        doctor: items,
                                                      );
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .backColor(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
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
                                                            weight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
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
                                                            weight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black))
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
              ),
      ),
    );
  }
}
