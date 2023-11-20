import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants/app_style.dart';
import '../constants/textstyle.dart';
import '../controller/onboard_controller/onboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.off(() => const OnBoardScrean());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                maxRadius: 40,
                backgroundColor: AppColor.bgColor(),
                child: Animate(
                    effects: [
                      const SlideEffect(curve: Curves.bounceIn),
                      FadeEffect(delay: 500.ms),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/images/splash.png'),
                    ))),
            Animate(
              effects: [
                FadeEffect(delay: 600.ms),
                const SlideEffect(curve: Curves.bounceIn),
              ],
              child: Text(
                'Medical',
                style: textStyle(
                    color: AppColor.backColor(),
                    size: 40,
                    weight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
