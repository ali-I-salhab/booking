import 'package:booking/core/constants/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  //the most important now
  int? get priority => 1;
  @override
  MyServices serv = Get.find();
  RouteSettings? redirect(String? route) {
    if (serv.shared.getString('step') == '2') {
      return const RouteSettings(name: AppRoutes.AuthPage);
    }
    if (serv.shared.getString('step') == '1') {
      return const RouteSettings(name: AppRoutes.signup);
    }
  }
}

class Onboardingmiddleware extends GetMiddleware {
  @override
  //the most important now
  int? get priority => 2;
  @override
  MyServices serv = Get.find();
  RouteSettings? redirect(String? route) {
    print("-------------------------mid onboarding");
    print(serv.shared.getString('onboarding'));
    if (serv.shared.getString('onboarding') == '1') {
      print("1");
      return const RouteSettings(name: AppRoutes.signup);
    }
  }
}
