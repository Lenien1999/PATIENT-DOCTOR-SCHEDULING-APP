import 'package:flutter/material.dart';

import '../constants/app_style.dart';
import '../constants/text_field.dart';
import '../constants/textstyle.dart';
import 'login_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/framePass.png',
                  // color: AppColor.bgColor(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create Your New Password',
                  textAlign: TextAlign.center,
                  style: textStyle(
                      size: 20, weight: FontWeight.w500, color: Colors.black),
                ),
                const SizedBox(
                  height: 15,
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
                      return '';
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
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
                      return '';
                    }
                  },
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(const Duration(seconds: 3), () {
                                // Task completed, close the dialog
                                Navigator.of(context).pop();
                                // Navigate to another page (e.g., LoginScreen)
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              });
                              return AlertDialog(
                                content: SizedBox(
                                  height: 400,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        'Your account is ready to use. You will be redirected to the Home page in a few seconds..',
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
                            });
                      },
                      child: Text(
                        'Next'.toUpperCase(),
                        style: textStyle(
                            size: 18,
                            weight: FontWeight.w500,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
