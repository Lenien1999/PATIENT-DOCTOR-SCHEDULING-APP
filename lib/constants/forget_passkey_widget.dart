 

import 'package:flutter/material.dart';

import 'app_style.dart';
import 'textstyle.dart';

class ForgetPasswordWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback ontap;
  const ForgetPasswordWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ontap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: ontap,
          child: Row(
            children: [
              Icon(icon, color: AppColor.bgColor(), size: 60),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      // ignore: deprecated_member_use
                      style: textStyle(
                          size: 16,
                          weight: FontWeight.bold,
                          color: AppColor.backColor())),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
