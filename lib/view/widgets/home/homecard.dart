import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeCard extends StatelessWidget {
  final String image;
  final String title;
  final void Function()? ontap;
  const HomeCard(
      {super.key,
      required this.image,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                          padding: EdgeInsets.all(10),
                          height: 7.h,
                          width: 7.h,
                          child: Image.asset(
                            image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(fontSize: 10.sp),
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
              Positioned(
                  top: 2.w,
                  right: 2.w,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(180)),
                    height: 10.w,
                    width: 10.w,
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
    );
  }
}
