import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

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
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                    height: Get.width / 2,
                    // width: ,

                    decoration: BoxDecoration(
                        gradient: LinearGradient(stops: [
                          1,
                          10
                        ], colors: [
                          AppColors.primarycolor,
                          AppColors.primarycolor.withOpacity(0.7)
                        ]),
                        // color: AppColors.primarycolor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        // borderRadius: BorderRadius.only(
                        //     topRight: Radius.circular(40.0),
                        //     bottomRight: Radius.circular(40.0),
                        //     topLeft: Radius.circular(40.0),
                        //     bottomLeft: Radius.circular(40.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              spreadRadius: 1,
                              blurRadius: 5),
                        ],
                        border: Border.symmetric()
                        // Border(bottom: BorderSide(color: Colors.red, width: 10)),
                        )),
                Positioned(
                    top: 100,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 2),
                              spreadRadius: 1,
                              blurRadius: 5),
                        ],
                        borderRadius: BorderRadius.circular(160),
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                  top: 100,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Image.asset(ImageAssets.logo, fit: BoxFit.cover),
                  ),
                ),
                const Positioned(
                  top: 10,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'sans',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.width / 5,
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    onTap: null,
                    title: Text(
                      "Notifications",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 22),
                    ),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.archivedorders);
                    },
                    title: Text(
                      "My profile",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 22),
                    ),
                    trailing: Icon(Ionicons.person),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.archivedorders);
                    },
                    title: Text(
                      "advanced",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 22),
                    ),
                    trailing: Icon(Ionicons.settings),
                  ),
                  ListTile(
                    onTap: () async {
                      // await controller.makePhoneCall('0934029909');
                    },
                    title: Text(
                      "Support team",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 22),
                    ),
                    trailing: Icon(Icons.phone),
                  ),
                  ListTile(
                    onTap: () {
                      MyServices ser = Get.find();
                      // FirebaseMessaging.instance.unsubscribeFromTopic("user");

                      // FirebaseMessaging.instance.unsubscribeFromTopic(
                      //     "user${ser.shared.getString('id')}");

                      ser.shared.clear();
                      Get.offAllNamed(AppRoutes.signup);
                    },
                    title: Text(
                      "Log out",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 22),
                    ),
                    trailing: Icon(Icons.logout),
                  ),
                  ListTile(
                    onTap: null,
                    title: Text(
                      "about us",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 22),
                    ),
                    trailing: Icon(Icons.sell_rounded),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
