import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/controller/home/mealplancontroller.dart';
import 'package:booking/controller/home/usercontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/view/home/homecardscreens/stopsale.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:booking/view/widgets/home/nextbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

showEditDeleteDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit or Delete"),
          content: Text("Choose an action"),
          actions: <Widget>[
            TextButton(
              child: Text("Edit"),
              onPressed: () {
                // Add edit logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                // Add delete logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      });
}

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    Usercontroller controller = Get.put(Usercontroller());

    return Scaffold(
      appBar: CustomAppBar(pagetitle: "Users"),
      body: Container(
        height: 80.h,
        child: ListView(
          shrinkWrap: true,
          children: [
            CustomProfileCard(
                image: ImageAssets.profile,
                flag: ImageAssets.flag,
                name: "yousser",
                permition: "admin"),
            InkWell(
              onTap: () {
                showadduserdialogue(context, () async {
                  await controller.addusers();
                }, () {
                  Get.back(canPop: false);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(ImageAssets.more),
                  ),
                  Text("    Add more users"),
                ],
              ),
            ),
            GetBuilder<Usercontroller>(builder: (controller) {
              return Handlingdataview(
                  statusrequest: controller.statusrequest,
                  widget: Column(
                    children: [
                      ...List.generate(
                          controller.users.length,
                          (index) => InkWell(
                                onTap: () {
                                  showEditDeleteDialog(context);
                                },
                                child: Customusercard(
                                  username: controller.users[index]
                                      ['user_name'],
                                  userpermition: controller.users[index]
                                      ['user_permitions'],
                                  useremail: controller.users[index]
                                      ['user_email'],
                                  password: controller.users[index]
                                      ['user_password'],
                                  desc: controller.users[index]['user_desc'],
                                  image: controller.users[index]
                                      ['user_profileimage'],
                                  phone: controller.users[index]['user_pohone'],
                                ),
                              ))
                    ].animate(delay: Duration(milliseconds: 300)).flip(),
                  ));
            })
          ],
        ),
      ),
    );
  }
}

class Customusercard extends StatelessWidget {
  final String username;
  final String userpermition;
  final String useremail;
  final String password;
  final String desc;
  final String image;
  final String phone;

  const Customusercard({
    super.key,
    required this.phone,
    required this.username,
    required this.userpermition,
    required this.useremail,
    required this.password,
    required this.desc,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.h),
      margin: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            width: 10.h,
            height: 10.h,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new CachedNetworkImageProvider(
                    ApiApplinks.profilesimagefolder + image),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.sp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(username),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.sp),
                      color: Colors.blueAccent,
                      width: 0.5.w,
                      height: 3.h,
                    ),
                    Column(
                      children: [
                        Container(
                          // width: 5.w,
                          child: Text(
                            useremail,
                            style: TextStyle(
                                fontSize: 7.sp, color: AppColors.blue),
                          ),
                        ),
                        Container(
                          child: Text(
                            phone,
                            style: TextStyle(
                                fontSize: 7.sp, color: AppColors.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(child: Text("password : " + password)),
                Container(
                  padding: EdgeInsets.all(3.sp),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Text(desc),
                  width: 60.w,
                )
              ],
            ),
          )
          // ClipRect(
          //   child: CachedNetworkImage(
          //       imageUrl: ApiApplinks.profilesimagefolder + image),
          // )
        ],
      ),
    );
  }
}

showadduserdialogue(
    context, GestureTapCallback onadd, void Function() oncancel) {
  Usercontroller controller = Get.find();
  showDialog(
      context: context,
      builder: (s) {
        return UnconstrainedBox(
          child: Container(
            color: AppColors.primarycolor,
            width: 80.w,
            height: 90.h,
            child: Material(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    4.sp, 4.sp, 4.sp, MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Add New user",
                            style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 4.h),
                        // height: 30.h,
                        width: 100.w,
                        // immages
                        child:
                            GetBuilder<Usercontroller>(builder: (controller) {
                          return controller.userprofileimage == null
                              ? InkWell(
                                  onTap: () {
                                    showbottomsheet(() async {
                                      controller.userprofileimage =
                                          await filesuploadgalllery();

                                      controller.update();
                                      Get.back(canPop: false);
                                    }, () async {
                                      File a = await imageuploadcamera();
                                      controller.userprofileimage = a;
                                      controller.update();
                                      Get.back(canPop: false);
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Ionicons.cloud_upload,
                                        color: AppColors.blue,
                                        size: 10.w,
                                      ),
                                      const Text("Select User Profile image")
                                    ],
                                  ),
                                )
                              : Container(
                                  child: CircleAvatar(
                                    radius: 10.h,
                                    backgroundImage:
                                        FileImage(controller.userprofileimage!),
                                  ),
                                );
                        })),
                    CustomTextformfieldAuth(
                      title: "user name",
                      hint: "user permition",
                      mycontroller: controller.username,
                    ),
                    CustomTextformfieldAuth(
                      maxlines: 2,
                      title: "Description",
                      hint: "Enter user description",
                      mycontroller: controller.userdesc,
                    ),
                    CustomTextformfieldAuth(
                      // maxlines: 5,
                      title: " email",
                      hint: "Enter user email",
                      mycontroller: controller.email,
                    ),
                    CustomTextformfieldAuth(
                      title: "phone",
                      hint: "enter your phone",
                      isphone: true,
                      mycontroller: controller.phone,
                    ),
                    CustomTextformfieldAuth(
                      // maxlines: 5,
                      title: "password",
                      hint: "Enter your Password",
                      mycontroller: controller.passwword,
                    ),
                    Text("select user permitions"),
                    GetBuilder<Usercontroller>(builder: (controller) {
                      return SizedBox(
                        width: 80.w,
                        height: 10.h,
                        // margin: EdgeInsets.symmetric(horizontal: 2.w),
                        // color: AppColors.greytextformfield,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                                controller.hoteliconssvg.length,
                                (index) => InkWell(
                                      onTap: () {
                                        controller.hoteliconssvg[index]
                                                ['selected'] =
                                            !controller.hoteliconssvg[index]
                                                ['selected'];

                                        controller.update();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: controller
                                                        .hoteliconssvg[index]
                                                    ['selected']
                                                ? AppColors.green
                                                : AppColors.greytextformfield),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              controller.hoteliconssvg[index]
                                                  ['icon'],
                                              // color: controller
                                              //             .hoteliconssvg[index]
                                              //         ['selected']
                                              //     ? Colors.white
                                              //     : AppColors.black
                                              //         .withOpacity(0.3),
                                              width: 10.w,
                                              height: 10.w,
                                            ),
                                            Text(
                                              controller.hoteliconssvg[index]
                                                  ['icon_name'],
                                              style: TextStyle(
                                                  color: controller
                                                              .hoteliconssvg[
                                                          index]['selected']
                                                      ? Colors.white
                                                      : AppColors.black
                                                          .withOpacity(0.3)),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                          ],
                        ),
                      );
                    }),
                    GetBuilder<Usercontroller>(builder: (controller) {
                      return Handlingdataview(
                          statusrequest: controller.addstatusrequest,
                          widget: Container(
                            margin: EdgeInsets.all(2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomGroupButton(
                                    text: "add",
                                    ontap: onadd,
                                    color: AppColors.green),
                                CustomGroupButton(
                                    text: "cancel",
                                    ontap: oncancel,
                                    color: AppColors.red)
                              ],
                            ),
                          ));
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
