import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class HomeCard extends StatelessWidget {
  final String image;
  final String title;
  bool status;
  final void Function()? ontap;
  HomeCard({
    super.key,
    required this.image,
    required this.title,
    required this.ontap,
    this.status = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: UnconstrainedBox(
        child: SizedBox(
          height: 11.h,
          width: 11.h,
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(12.sp),
            color: Colors.white,
            elevation: 9,
            shadowColor: Colors.black,
            child: Stack(
              children: [
                Container(
                  // padding: EdgeInsets.all(0.5.h),
                  // margin: EdgeInsets.all(1.h),
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            // // color: Colors.red,

                            height: 4.h,
                            width: 4.h,
                            child: Image.asset(
                              image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              title,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes the shadow direction
                      ),
                    ],
                    color: Colors.white,
                  ),
                ),
                status
                    ? Positioned(
                        top: 4.sp,
                        right: 4.sp,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(180)),
                          height: 7.w,
                          width: 7.w,
                          child: Center(
                            child: Icon(
                              Icons.highlight_off,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ))
                    : Positioned(
                        top: 4.sp,
                        right: 4.sp,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(180)),
                          height: 7.w,
                          width: 7.w,
                          child: Center(
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20.sp,
                            ),
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
