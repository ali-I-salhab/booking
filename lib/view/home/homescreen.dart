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
      // color: Colors.black.withOpacity(0.12),
      padding: EdgeInsets.only(bottom: 10.sp),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(3.sp),
            child: GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
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
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              padding: EdgeInsets.all(4.sp),
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.stopsale,
                          arguments: {"hotel": controller.hotel});
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 9,
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        height: 16.h,
                        width: 25.w,
                        // margin: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Image.asset(
                                  ImageAssets.stopsale,
                                  height: 5.h,
                                  width: 5.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "Stop Sale",
                                style: TextStyle(fontSize: 10.sp),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.updates,
                          arguments: {"hotel": controller.hotel});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 9,
                        borderRadius: BorderRadius.circular(10.sp),
                        child: Container(
                          width: 20.w,
                          margin: EdgeInsets.symmetric(horizontal: 0.5.h),
                          child: Center(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Image.asset(
                                    ImageAssets.update,
                                    height: 5.h,
                                    width: 5.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(
                                  "Updates",
                                  style: TextStyle(fontSize: 10.sp),
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 9,
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 1.w),
                        height: 16.h,
                        width: 25.w,
                        // margin: EdgeInsets.symmetric(horizontal: , vertical: 10),
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Image.asset(
                                  ImageAssets.notifications,
                                  height: 5.h,
                                  width: 5.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "Notifications",
                                style: TextStyle(fontSize: 10.sp),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            color: AppColors.black.withOpacity(0.001),
            margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
            padding: EdgeInsets.all(4.sp),
            height: 10.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 9,
                    borderRadius: BorderRadius.circular(22.sp),
                    shadowColor: Colors.black.withOpacity(0.9),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      // height: 16.h,
                      // width: 50.w,
                      // margin: EdgeInsets.symmetric(horizontal: , vertical: 10),
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Image.asset(
                                ImageAssets.confirmedorders,
                                height: 5.h,
                                width: 5.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              "confirmed orders",
                              style: TextStyle(fontSize: 10.sp),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 9,
                    borderRadius: BorderRadius.circular(22.sp),
                    shadowColor: Colors.black.withOpacity(0.9),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      // height: 16.h,
                      // width: 50.w,
                      // margin: EdgeInsets.symmetric(horizontal: , vertical: 10),
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Image.asset(
                                ImageAssets.pendingorders,
                                height: 5.h,
                                width: 5.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              "Pending orders",
                              style: TextStyle(fontSize: 10.sp),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ].animate(interval: 400.ms).flip(duration: 300.ms),
      ),
    ));
  }
}
