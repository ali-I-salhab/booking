import 'package:booking/controller/onboarding/onboardingcontroller.dart';
import 'package:booking/core/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customdotonboarding extends StatelessWidget {
  const Customdotonboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingControllerImp>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
              3,
              (index) => AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    width: controller.currentpage == index ? 15 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.blue),
                    duration: const Duration(milliseconds: 500),
                  ))
        ],
      );
    });
  }
}
