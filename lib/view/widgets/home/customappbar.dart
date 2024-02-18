import 'package:booking/controller/home/homecontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

PreferredSizeWidget CustomAppBar({String? pagetitle = ""}) {
  HomeController controller = Get.find();
  return PreferredSize(
      preferredSize: Size.fromHeight(8.h), // Set this height
      child: Container(
        color: Colors.black.withOpacity(0.12),
        height: 20.h,
        margin: EdgeInsets.only(top: 2.h),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 10.sp,
              top: 20.sp,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    // color: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20.sp,
                    )),
              ),
            ),
            Positioned(
                right: 10.sp,
                top: 15.sp,
                // alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 30.sp,
                      width: 30.sp,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.sp),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: ImageAssets.networkhotellogo +
                              controller.hotel!.hotelLogo.toString(),
                        ),
                      ),
                    ),
                    Container(
                        // color: Colors.red,
                        // width: 60.sp,
                        height: 10.sp,
                        child: FittedBox(
                            child:
                                Text(controller.hotel!.hotelName!.toString())))
                  ],
                )), // This Icon
            // Spacer(
            //   flex: 2,
            // ),
            Positioned(
              top: 10.sp,
              left: 42.w,
              child: SizedBox(
                height: 30.sp,
                width: 50.sp,
                child: ClipRRect(
                  child: Image.asset(
                    ImageAssets.homelogo,

                    fit: BoxFit.cover,
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 40.sp,
              left: 40.w,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(20.sp),
                color: Colors.white,
                elevation: 9,
                shadowColor: Colors.black,
                child: SizedBox(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.sp),
                  width: 20.w,
                  height: 4.5.w,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Center(
                      child: FittedBox(
                    child: Text(
                      !(pagetitle == "")! ? "$pagetitle" : "here page",
                      style: TextStyle(color: Colors.black, fontSize: 23.sp),
                    ),
                  )),
                )),
              ),
            ).animate().scale(duration: Duration(milliseconds: 700))
          ],
        ),
      ));
}
