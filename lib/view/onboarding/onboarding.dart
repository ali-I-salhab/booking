import 'package:booking/controller/onboarding/onboardingcontroller.dart';
import 'package:booking/view/widgets/onboarding/onboardingcustombutton.dart';
import 'package:booking/view/widgets/onboarding/onboardingdots.dart';
import 'package:booking/view/widgets/onboarding/sonboardingcustomslider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: const Column(
            children: [
              Expanded(
                flex: 3,
                child: CustomOnboardingSlider(),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [Customdotonboarding(), CustomButtonOnboarding()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
