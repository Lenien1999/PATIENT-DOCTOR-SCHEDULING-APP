import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_style.dart';

import '../constants/forget_passkey_widget.dart';
 
import '../constants/text_field.dart';
import '../constants/textstyle.dart';

import 'auth_controller/authcontroller.dart';
import 'email_phonenumber.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
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
                    controller: email,
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      // Use RegExp for basic email validation
                      if (!RegExp(
                              r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      // ignore: null_check_always_fails
                      return null; // Return null if the input is valid
                    },
                    title: 'Email',
                    isTrailing: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFielWidget(
                    controller: password,
                    icon: Icons.fingerprint,
                    title: 'Password',
                    isTrailing: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an Full Name';
                      } else if (value.length < 6) {
                        return 'Password lenght should greater than 6';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Forget Password!',
                                          style: textStyle(
                                              size: 20,
                                              weight: FontWeight.bold,
                                              color: AppColor.backColor())),
                                      Text(
                                          'Select on of the option given below to reset your password',
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              size: 16,
                                              weight: FontWeight.w500,
                                              color: Colors.black)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ForgetPasswordWidget(
                                        ontap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (__) {
                                            return const ForgetPasswordMailScreen(
                                              isMail: true,
                                            );
                                          }));
                                        },
                                        subtitle:
                                            'Reset via E-mail verification',
                                        title: 'E-MAIL',
                                        icon: Icons.mail_outline_outlined,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ForgetPasswordWidget(
                                        ontap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (__) {
                                            return const ForgetPasswordMailScreen(
                                              isMail: false,
                                            );
                                          }));
                                        },
                                        subtitle:
                                            'Reset via Phone verification',
                                        title: 'Phone No',
                                        icon: Icons.mobile_friendly_rounded,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Text(
                          'Forget Password?',
                          style: textStyle(
                              size: 18,
                              weight: FontWeight.w600,
                              color: Colors.black),
                        )),
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
                          print('object');
                          await controller.signInUser(
                              email: email.text, password: password.text);
                        }
                      },
                      child: Text(
                        "Login",
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
                      text: "Don't have an Account?",
                      style: textStyle(
                          size: 16,
                          weight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUpScreen();
                          }));
                        },
                      text: " Sign Up",
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
