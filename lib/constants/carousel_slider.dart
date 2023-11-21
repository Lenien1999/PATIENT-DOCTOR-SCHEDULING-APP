import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import 'app_style.dart';
import 'carousel_model.dart';
import 'textstyle.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.item,
  });

  final CarouselModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColor.backColor()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: textStyle(
                      size: 16, weight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  item.subtitle,
                  maxLines: 4,
                  style: textStyle(
                          size: 12,
                          weight: FontWeight.w400,
                          color: Colors.white)
                      .copyWith(
                          letterSpacing: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Image.asset(
                item.image,
                height: 100,
                fit: BoxFit.fitHeight,
              ))
        ],
      ),
    );
  }
}

class CarouselDot extends StatelessWidget {
  const CarouselDot({
    super.key,
    required CarouselController controller,
    required this.currentPage,
  }) : _controller = controller;

  final CarouselController _controller;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: carouselList.asMap().entries.map((entry) {
        return InkWell(
          onTap: () {
            _controller.animateToPage(entry.key);
          },
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  currentPage == entry.key ? AppColor.backColor() : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
