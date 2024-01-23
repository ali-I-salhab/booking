import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NextButton extends StatelessWidget {
  final void Function()? ontap;
  String title;

  NextButton({super.key, this.ontap, this.title = "Next"});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 5.h,
        decoration: BoxDecoration(
            color: AppColors.blue, borderRadius: BorderRadius.circular(18)),
        // padding: EdgeInsets.all(2.w),
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        child: Center(
          child: Container(
            // margin: EdgeInsets.all(1.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70.w,
                  child: Center(
                    child: Text(
                      " $title",
                      style: TextStyle(
                          height: 1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_circle_right,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
