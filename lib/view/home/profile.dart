import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // SettingController controller = Get.put(SettingController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80.sp,
                  width: 80.sp,
                  child: Image.asset(ImageAssets.profile),
                  decoration: BoxDecoration(
                      color: AppColors.greysetting, shape: BoxShape.circle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copy, color: AppColors.bluetext),
                    Text(
                      "#12ere4343rer",
                      style: TextStyle(color: AppColors.bluetext),
                    )
                  ],
                )
              ],
            ),
            Settingcard(
              name: 'profile',
              icon: Ionicons.person_outline,
            ),
            Settingcard(
              name: 'حساباتي',
              icon: Icons.account_box_outlined,
            ),
            Settingcard(
              name: 'Get money',
              icon: Icons.attach_money_outlined,
            ),
            Settingcard(
              name: 'Questions',
              icon: Icons.question_mark,
            ),
            Settingcard(
              name: 'Support',
              icon: Icons.support_agent,
            ),
            Settingcard(
              name: 'Change language',
              icon: Icons.language_outlined,
            ),
            SizedBox(
              height: Get.width / 5,
            ),
          ],
        ),
      ),
    );
  }
}

class Settingcard extends StatelessWidget {
  final String name;
  final IconData icon;
  const Settingcard({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 10.sp,
              ),
              Text(
                name,
                style: TextStyle(color: AppColors.bluetext),
              ),
            ],
          ),
          Transform.rotate(angle: 3.14, child: Icon(Icons.arrow_back_ios)),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: AppColors.greysetting),
    );
  }
}
