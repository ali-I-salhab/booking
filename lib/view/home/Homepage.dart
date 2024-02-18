import 'dart:math';

import 'package:booking/controller/home/authaccountcontroller.dart';
import 'package:booking/controller/home/homecontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/functions/alertexitapp.dart';
import 'package:booking/core/functions/buildfab.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final _key = GlobalKey<ExpandableFabState1>();

    HomeController controller = Get.put(HomeController());
    return WillPopScope(
      onWillPop: () async {
        print("back from home page");
        Get.put(AuthaccountinfoController());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: CustomAppBar(pagetitle: "Main"),
        bottomNavigationBar: GetBuilder<HomeController>(
            builder: (controller) => BottomNavigationBar(
                    currentIndex: controller.currentscreen,
                    selectedItemColor: AppColors.bluetext,
                    backgroundColor: AppColors.greysetting,
                    onTap: (index) {
                      controller.currentscreen = index;
                      controller.update();
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home_outlined,
                            // color: AppColors.bluetext,
                          ),
                          label: "home"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.settings,
                            // color: AppColors.bluetext,
                          ),
                          label: "setting")
                    ]))
        // bottomNavigationBar: ConvexAppBar(
        //   // cornerRadius: 20.sp,

        //   // gradient: LinearGradient(
        //   //     colors: [Colors.black.withOpacity(0.12), Colors.black]),
        //   activeColor: AppColors.blue,

        //   // style: TabStyle.fixed,
        //   top: -20,
        //   // height: 20,
        //   onTap: (index) {
        //     if (index == 1) {}
        //     controller.currentscreen = index;
        //     controller.update();
        //   },
        //   // backgroundColor: AppColors.blue,
        //   backgroundColor: Colors.black12,
        //   color: Colors.black.withOpacity(0.12),
        //   items: [
        //     TabItem(icon: Icons.home, title: 'Home'),
        //     // TabItem(icon: Icons.people, title: 'Wallet'),
        //     TabItem(icon: Icons.people, title: 'Settings'),
        //   ],
        // ),
        ,
        body: GetBuilder<HomeController>(
            builder: (controller) =>
                controller.Screens[controller.currentscreen]),
      ),
    );
  }
}
