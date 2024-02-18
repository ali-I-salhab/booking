import 'package:booking/controller/home/homecontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/functions/buildfab.dart';
import 'package:booking/view/widgets/home/authaccountcard.dart';
import 'package:booking/view/widgets/home/homecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return SafeArea(
        child: Container(
      padding: EdgeInsets.only(bottom: 2.sp),
      child: ListView(physics: BouncingScrollPhysics(), children: [
        Container(
          child: GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.2),
            children: [
              HomeCard(
                image: ImageAssets.details,
                title: 'Details',
                ontap: () {
                  Get.toNamed(AppRoutes.details,
                      arguments: {"details": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.photos,
                title: 'Photos',
                ontap: () {
                  Get.toNamed(AppRoutes.photos,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.group,
                title: 'Guest groups',
                ontap: () {
                  Get.toNamed(AppRoutes.groups,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.mealplan,
                title: 'Meal plan',
                ontap: () {
                  Get.toNamed(AppRoutes.mealplan,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.payment,
                title: 'Paymnet',
                ontap: () {
                  Get.toNamed(AppRoutes.payment,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.rooms,
                title: 'Rooms',
                ontap: () {
                  Get.toNamed(AppRoutes.rooms,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.rates,
                title: 'Rates',
                ontap: () {
                  Get.toNamed(AppRoutes.rates,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.available,
                title: 'Availbility',
                ontap: () {},
              ),
              HomeCard(
                image: ImageAssets.users,
                title: 'Users',
                ontap: () {
                  Get.toNamed(AppRoutes.users,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.users,
                title: 'Periods',
                ontap: () {
                  Get.toNamed(AppRoutes.periods,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.stopsale,
                title: 'Stop sale',
                ontap: () {
                  Get.toNamed(AppRoutes.stopsale,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.update,
                title: 'updates',
                ontap: () {
                  Get.toNamed(AppRoutes.updates,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.notifications,
                title: 'notifications',
                ontap: () {
                  Get.toNamed(AppRoutes.periods,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.pendingorders,
                title: 'pending orders',
                ontap: () {
                  Get.toNamed(AppRoutes.periods,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.periods,
                title: 'confirmed orders',
                ontap: () {
                  Get.toNamed(AppRoutes.periods,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.gmail,
                title: 'Emails',
                ontap: () {
                  Get.toNamed(AppRoutes.periods,
                      arguments: {"hotel": controller.hotel});
                },
              ),
              HomeCard(
                image: ImageAssets.coupon,
                title: 'coupons',
                ontap: () {
                  Get.toNamed(AppRoutes.periods,
                      arguments: {"hotel": controller.hotel});
                },
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
