import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/controller/home/stopsalecontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Stopsale extends StatelessWidget {
  const Stopsale({super.key});

  @override
  Widget build(BuildContext context) {
    StopSaleController controller = Get.put(StopSaleController());
    return Scaffold(
      appBar: CustomAppBar(pagetitle: "Stop Sale"),
      body: ListView(
        children: [
          CustomProfileCard(
              image: ImageAssets.profile,
              flag: ImageAssets.flag,
              name: "ali",
              permition: "permition"),
          InkWell(
            onTap: () {
              showaddmealplandialog(context, () {}, () {});
            },
            child: UnconstrainedBox(
              child: Container(
                padding: EdgeInsets.all(5.sp),
                decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Add Stop sale period",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          GetBuilder<StopSaleController>(builder: (controller) {
            return Handlingdataview(
                statusrequest: controller.viewstopsalesstatusrequest,
                widget: ListView(
                  shrinkWrap: true,
                  children: [
                    ...List.generate(
                        controller.stopsale.length,
                        (index) => Stopsalecard(
                              () {},
                              () async {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return AlertDialog(
                                        title: Text("delete this content  ? "),
                                        actions: [
                                          CustomGroupButton(
                                              text: "confirm",
                                              ontap: () {
                                                Get.back(canPop: false);
                                                controller.deletestopsale(
                                                    controller.stopsale[index]
                                                        .stopsaleId!);
                                                controller.stopsale.removeWhere(
                                                    (element) =>
                                                        element.roomName ==
                                                        controller
                                                            .stopsale[index]
                                                            .roomName!);
                                                controller.update();
                                              },
                                              color: AppColors.green),
                                          CustomGroupButton(
                                              text: "cancel",
                                              ontap: () {
                                                Get.back(canPop: false);
                                              },
                                              color: AppColors.red)
                                        ],
                                      );
                                    });
                                controller.update();
                                // await controller.deletestopsale(
                                //     controller.stopsale[index].stopsaleId!);
                              },
                              image: controller.stopsale[index].roomLogo!,
                              roomname: controller.stopsale[index].roomName!,
                              startdate: controller
                                  .stopsale[index].stopsaleStart!
                                  .substring(0, 10),
                              lastdate: controller.stopsale[index].stopsaleEnd!
                                  .substring(0, 10),
                            ))
                  ].animate(interval: 400.ms).flip(duration: 300.ms),
                ));
          })
        ],
      ),
    );
  }
}

class Stopsalecard extends StatelessWidget {
  final String image;

  final String roomname;
  final String startdate;
  final String lastdate;
  void Function()? ondelete;
  void Function()? onedit;

  // ignore: non_constant_identifier_names
  Stopsalecard(
    this.onedit,
    this.ondelete, {
    super.key,
    required this.image,
    required this.roomname,
    required this.startdate,
    required this.lastdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 80.w,
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes the shadow direction
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(90)),
      child: Container(
        // color: AppColors.blue,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.green),
              height: 8.h,
              width: 8.h,
              child: Center(
                  child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: ApiApplinks.roomimagesfolder + "$image",
              )),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              // color: AppColors.grey,
              width: 50.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "$roomname",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "roomgr",
                    style: TextStyle(color: AppColors.grey),
                  ),
                  Container(
                    // color: Colors.indigo,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.date_range_outlined),
                                  Text("from"),
                                ],
                              ),
                              Text(startdate)
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            height: 8.h,
                            width: 0.5.w,
                            color: AppColors.greytextformfield,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.date_range_outlined),
                                  Text("to"),
                                ],
                              ),
                              Text(lastdate)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(5.sp)),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  onTap: onedit,
                ),
                SizedBox(
                  height: 10.w,
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(5.sp)),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onTap: ondelete,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

showaddmealplandialog(
    context, GestureTapCallback onadd, GestureTapCallback oncancel) {
  StopSaleController controller = Get.find();
  showDialog(
      context: context,
      builder: (c) {
        return Material(
            color: AppColors.black.withOpacity(0.03),
            child: UnconstrainedBox(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(8.sp),
                height: 50.h,
                width: 67.w,
                child: Column(children: [
                  Text(
                    "Add Stop Sale period",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (s) {
                            return Dialog(
                              child: Container(
                                height: 20.h,
                                width: 10.w,
                                color: AppColors.white,
                                child: ListView(
                                  children: [
                                    ...List.generate(
                                      controller.alladdedrooms.length,
                                      (index) => ListTile(
                                        onTap: () {
                                          controller.roomid = controller
                                              .alladdedrooms[index]!.roomId!;
                                          controller.roomname = controller
                                              .alladdedrooms[index]!.roomName!;
                                          controller.update();
                                          Get.back(canPop: false);
                                        },
                                        title: Text(controller
                                            .alladdedrooms[index]!.roomName!),
                                        leading: Icon(Icons.donut_large),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(14.sp)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 4.sp,
                          ),
                          Icon(Icons.arrow_drop_down_circle_sharp),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.sp),
                            color: AppColors.black,
                            width: 2.sp,
                            height: 30.sp,
                          ),
                          GetBuilder<StopSaleController>(builder: (controller) {
                            return controller.roomid == null
                                ? Text("Select type")
                                : Text(controller.roomname!);
                          })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 600)))
                              .then((value) {
                            controller.startdate =
                                value.toString().substring(0, 10);
                            controller.update();
                          });
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [Text("from"), Icon(Icons.date_range)],
                            ),
                            GetBuilder<StopSaleController>(
                                builder: (controller) {
                              return controller.startdate == null
                                  ? Text("non")
                                  : Text(controller.startdate!);
                            })
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 600)))
                              .then((value) {
                            controller.enddate =
                                value.toString().substring(0, 10);
                            controller.update();
                          });
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [Text("to"), Icon(Icons.date_range)],
                            ),
                            GetBuilder<StopSaleController>(
                                builder: (controller) {
                              return controller.enddate == null
                                  ? Text("non")
                                  : Text(controller.enddate!);
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomGroupButton(
                          text: "Add",
                          ontap: () async {
                            await controller.addstopsale(controller.roomid!,
                                controller.startdate!, controller.enddate!);
                          },
                          color: AppColors.green),
                      CustomGroupButton(
                          text: "Cancel",
                          ontap: () {
                            controller.enddate = null;
                            controller.startdate = null;
                            controller.roomid = null;
                            Get.back(canPop: false);
                          },
                          color: AppColors.red)
                    ],
                  )
                ]),
              ),
            ));
      });
}
