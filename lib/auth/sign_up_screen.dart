 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '../constants/app_style.dart';

import '../constants/text_field.dart';
import '../constants/textstyle.dart';
import '../db_manager/user_controller.dart';
import 'auth_controller/auth_model.dart';
import 'auth_controller/authcontroller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final controller = Get.put(AuthController());
  final usercontroller = Get.put(FirebaseMethods());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    color: AppColor.bgColor(),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFielWidget(
                    controller: fullname,
                    icon: Ionicons.person_add,
                    title: 'Full Name',
                    isTrailing: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFielWidget(
                    controller: email,
                    icon: Icons.email,
                    title: 'Email',
                    isTrailing: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFielWidget(
                    controller: password,
                    icon: Icons.fingerprint,
                    title: 'Password',
                    isTrailing: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFielWidget(
                    controller: phoneNumber,
                    icon: Icons.phone_sharp,
                    title: 'Phone Number',
                    isTrailing: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColor.backColor(),
                      ),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await controller.registerUser(
                            email: email.text,
                            password: password.text,
                          );

                          // Check if the user is successfully registered
                          if (controller.fireBaseUser.value != null) {
                            final user = UserModel(
                              id: controller.fireBaseUser.value!.uid,
                              fullName: fullname.text,
                              email: email.text,
                              phoneNo: phoneNumber.text,
                              password: password.text,
                            );

                            // Store additional user information in Firestore
                            await usercontroller.addUserData(user);

                            Get.snackbar(
                              'Success',
                              'Your account has been created',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green.withOpacity(0.1),
                              colorText: Colors.green,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Your account has been created',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.1),
                              colorText: Colors.red,
                            );
                          }
                        }
                      },
                      child: Text(
                        'Sign up',
                        style: textStyle(
                          size: 18,
                          weight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'OR',
                    style: textStyle(
                        size: 18, weight: FontWeight.w600, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2)))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/fb.png'),
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2)))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/google.png',
                              width: 40,
                              height: 37,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Already have an Account?",
                      style: textStyle(
                          size: 16,
                          weight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => const LoginScreen());
                        },
                      text: " Sign in",
                      style: textStyle(
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColor.backColor()),
                    ),
                  ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
