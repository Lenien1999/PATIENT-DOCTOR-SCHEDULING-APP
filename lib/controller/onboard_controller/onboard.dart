import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/login_screen.dart';
import '../../constants/app_style.dart';
import '../../constants/textstyle.dart';
import 'onboardmodel.dart';

class OnBoardScrean extends StatefulWidget {
  const OnBoardScrean({super.key});

  @override
  State<OnBoardScrean> createState() => _OnBoardScreanState();
}

class _OnBoardScreanState extends State<OnBoardScrean> {
  PageController pageController = PageController();

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: pageController,
            itemCount: onBoardList.length,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final item = onBoardList[index];
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                        )),
                    Flexible(
                      child: Text(
                        item.title,
                        style: textStyle(
                            size: 24,
                            weight: FontWeight.bold,
                            color: AppColor.backColor()),
                      ),
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: currentPage,
                      count: onBoardList.length,
                      effect: WormEffect(
                          activeDotColor: AppColor.backColor(), dotHeight: 5.0),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentPage < onBoardList.length - 1) {
                            currentPage++;
                            pageController.animateToPage(
                              currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.backColor(),
                        ),
                        child: Text(
                          item.counterText,
                          style: textStyle(
                              size: 18,
                              weight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
