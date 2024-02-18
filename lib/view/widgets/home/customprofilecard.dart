import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/services/services.dart';
import 'package:booking/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomProfileCard extends StatelessWidget {
  final String image;
  final String flag;
  final String name;
  final String permition;
  const CustomProfileCard(
      {super.key,
      required this.image,
      required this.flag,
      required this.name,
      required this.permition});

  @override
  Widget build(BuildContext context) {
    MyServices ser = Get.find();
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.editProfile);
      },
      child: Container(
        margin: EdgeInsets.all(3.sp),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
              radius: 30.sp,
            ),
            SizedBox(
              width: 3.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // color: AppColors.black,
                  width: 40.w,

                  child: Text(
                    ser.shared.getString("username").toString(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(),
                  ),
                ),
                Container(
                  width: 40.w,
                  child: Text(
                    permition,
                    style: GoogleFonts.poppins(color: AppColors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                flag,
                fit: BoxFit.fill,
              ),
              radius: 30.sp,
            ),
          ],
        ),
      ),
    );
  }
}
