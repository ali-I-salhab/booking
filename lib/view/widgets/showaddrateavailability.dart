import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

showaddrateavailabilitydialogue(context, String title, VoidCallback ontap) {
  return Get.dialog(UnconstrainedBox(
    child: Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.sp),
          child: Container(
            // margin: EdgeInsets.only(bottom: 2.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.12),
            ),
            height: 20.h,
            width: 40.w,
            child: Material(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: AppColors.blue,
                  child: Text(
                    "  $title  ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onEditingComplete: ontap,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    ),
  ));
}
