
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_style.dart';
import '../constants/navigation_widget.dart';
import '../constants/text_field.dart';
import '../constants/textstyle.dart';
import 'auth_controller/authcontroller.dart';

class ForgetPasswordMailScreen extends StatefulWidget {
  final bool isMail;
  const ForgetPasswordMailScreen({super.key, required this.isMail});

  @override
  State<ForgetPasswordMailScreen> createState() =>
      _ForgetPasswordMailScreenState();
}

class _ForgetPasswordMailScreenState extends State<ForgetPasswordMailScreen> {
  final controller = TextEditingController();
  final _key = GlobalKey<FormState>();
  final _authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30 * 4,
              ),
              Image.asset(
                'assets/images/splash.png',
                color: AppColor.bgColor(),
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                'Forget Password',
                // ignore: deprecated_member_use
                style: textStyle(
                    size: 26,
                    weight: FontWeight.bold,
                    color: AppColor.backColor()),
              ),
              Text(
                'Make it work, Make it right, make fast',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFielWidget(
                        controller: controller,
                        icon: widget.isMail
                            ? Icons.email
                            : Icons.phone_forwarded_sharp,
                        title: widget.isMail ? 'Email' : 'Phone Number',
                        isTrailing: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      NavigationWidget(
                        title: 'Next',
                        tap: () {
                          _authcontroller.resetPassword(
                              controller.text.trim(), context);
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
