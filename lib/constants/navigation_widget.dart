import 'package:flutter/material.dart';

import 'app_style.dart';
import 'textstyle.dart';

class NavigationWidget extends StatelessWidget {
  final String title;
  final Function()? tap;
  const NavigationWidget({
    super.key,
    required this.title, this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return
     SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColor.backColor(),
          ),
          onPressed: tap,
          child: Text(
            title,
            style: textStyle(
                size: 18, weight: FontWeight.w500, color: Colors.white),
          )),
    );
  }
}
