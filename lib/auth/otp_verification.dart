 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../constants/app_style.dart';
import '../constants/navigation_widget.dart';
import '../constants/textstyle.dart';
import 'change_password.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key, required this.forgetPasswordText});
  final TextEditingController forgetPasswordText;

  @override
  Widget build(BuildContext context) {
    // var otp;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'OTP CODE VERIFICATION',
          style:
              textStyle(size: 16, weight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
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
                Text(
                  'Code has been sent to ${forgetPasswordText.text}',
                  textAlign: TextAlign.center,
                  style: textStyle(
                      size: 20, weight: FontWeight.w500, color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) async {
                    // otp = code;
                    // var isVerified = controller.verifyOtp(otp);
                    // await isVerified
                    //     ? Get.offAll(const DashBoard())
                    //     : Get.back();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Resend code in",
                    style: textStyle(
                        size: 20,
                        weight: FontWeight.w500,
                        color: const Color.fromARGB(255, 73, 72, 72)),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: " 50",
                    style: textStyle(
                        size: 16,
                        weight: FontWeight.w500,
                        color: AppColor.backColor()),
                  ),
                  TextSpan(
                    text: "s",
                    style: textStyle(
                        size: 20,
                        weight: FontWeight.w500,
                        color: const Color.fromARGB(255, 73, 72, 72)),
                  ),
                ])),
                const SizedBox(
                  height: 15,
                ),
                NavigationWidget(
                  title: 'Next',
                  tap: () {
                    Get.to(() {
                      return const ChangePassword();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
