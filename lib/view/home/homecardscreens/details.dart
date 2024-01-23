import 'dart:async';
import 'dart:io';

import 'package:booking/controller/home/detailscontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/showimagedialogue.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/view/home/homecardscreens/update.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:booking/view/widgets/home/nextbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    DetailsController controller = Get.put(DetailsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Get.previousRoute == "/homepage"
          ? CustomAppBar(pagetitle: "Details")
          : PreferredSize(
              preferredSize: Size.fromHeight(13.h),
              child: Text(""),
            ),
      body: Column(
        children: [
          Align(
              child: Get.previousRoute == "/homepage"
                  ? Text(
                      "Hotel Details",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "Add New Hotel",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
          CustomProfileCard(
              image: ImageAssets.profile,
              flag: ImageAssets.flag,
              name: "ali salhab",
              permition: "admin"),
          GetBuilder<DetailsController>(builder: (controller) {
            return Visibility(
              visible: controller.loading,
              replacement: UnconstrainedBox(
                child: SizedBox(
                  height: 10.h,
                  width: 10.h,
                  child: CircularProgressIndicator(
                    color: Colors.black12,
                    strokeWidth: 5.sp,
                  ),
                ),
              ),
              child: Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    InkWell(onTap: () {
                      showbottomsheet(() async {
                        controller.hotellogo = await filesuploadgalllery();
                        // controller.photos.add(x);

                        controller.update();
                        Get.back(canPop: false);
                      }, () async {
                        File a = await imageuploadcamera();
                        controller.hotellogo = a;
                        controller.update();
                        Get.back(canPop: false);
                      });
                      // Get.snackbar("title", "message");
                      // Get.bottomSheet(Text(""));
                    }, child:
                        GetBuilder<DetailsController>(builder: (controller) {
                      if (controller.hotel == null) {
                        if (controller.hotellogo == null) {
                          return Container(
                            alignment: Alignment.center,
                            height: 10.h,
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.cloud_upload_outlined),
                                Text("Upload hotel logo"),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            width: 80.w,
                            height: 80.w,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.file(
                                  controller.hotellogo!,
                                  fit: BoxFit.contain,
                                ),
                                Positioned(
                                  bottom: 4.h,
                                  right: 8.h,
                                  child: IconButton(
                                      onPressed: () async {
                                        print(controller.hotellogo);
                                        File cropped;

                                        cropped = await cropImage(
                                            controller.hotellogo!, context);
                                        cropped == null
                                            ? controller.hotellogo =
                                                controller.hotellogo
                                            : controller.hotellogo = cropped;
                                        ;
                                        controller.update();
                                        print(controller.hotellogo);
                                      },
                                      icon: Container(
                                        height: 50.sp,
                                        width: 50.sp,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 20.sp,
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          );
                        }
                        // here we add new hotel
                      } else {
                        return InkWell(
                          onTap: () {
                            showbottomsheet(() async {
                              controller.hotellogo =
                                  await filesuploadgalllery();
                              // controller.photos.add(x);

                              controller.update();
                              Get.back(canPop: false);
                            }, () async {
                              File a = await imageuploadcamera();
                              controller.hotellogo = a;
                              controller.update();
                              Get.back(canPop: false);
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 80.w,
                                height: 80.w,
                                child: controller.hotellogo == null
                                    ? UnconstrainedBox(
                                        child: Container(
                                          margin: EdgeInsets.all(2.w),
                                          height: 20.h,
                                          width: 20.w,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.sp),
                                            child: CachedNetworkImage(
                                                imageUrl: ImageAssets
                                                        .networkhotellogo +
                                                    '${controller.hotel!.hotelLogo}'),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(10.sp),
                                        child: Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            margin: EdgeInsets.all(20.sp),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.sp),
                                              child: Image.file(
                                                controller.hotellogo!,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                              ),
                              Positioned(
                                bottom: 5.h,
                                right: 10.h,
                                child: IconButton(
                                    onPressed: () async {
                                      print(controller.hotellogo);
                                      File cropped;

                                      cropped = await cropImage(
                                          controller.hotellogo!, context);
                                      cropped == null
                                          ? controller.hotellogo =
                                              controller.hotellogo
                                          : controller.hotellogo = cropped;
                                      ;
                                      controller.update();
                                      print(controller.hotellogo);
                                    },
                                    icon: PhysicalModel(
                                      color: Colors.transparent,
                                      shadowColor: Colors.black,
                                      elevation: 12.sp,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        );
                      }
                    })),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Hotel name"),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        child: TextFormField(
                          controller: controller.name,
                          decoration: InputDecoration(
                            hintText: "Enter your hotel name",
                            filled: true,
                            fillColor: AppColors.greytextformfield,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Number Hotel stars"),
                    ),
                    RatingBar.builder(
                      initialRating: controller.hotel == null
                          ? 1
                          : double.parse(
                              controller.hotel!.hotelRating.toString()),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        controller.rating = rating.toString();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Hotel Location"),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        child: TextFormField(
                          controller: controller.location,
                          decoration: InputDecoration(
                            hintText: "Enter your hotel name",
                            filled: true,
                            fillColor: AppColors.greytextformfield,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Hotel Description"),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (s) {
                            print(s);
                          },
                          onEditingComplete: () {
                            print("ali");
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          maxLines: 5,
                          controller: controller.desc,
                          decoration: InputDecoration(
                            hintText: "Enter your hotel description",
                            filled: true,
                            fillColor: AppColors.greytextformfield,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Hotel Icons"),
                    ),
                    GetBuilder<DetailsController>(builder: (controller) {
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
                                                ? AppColors.blue
                                                : AppColors.greytextformfield),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              controller.hoteliconssvg[index]
                                                  ['icon'],
                                              color: controller
                                                          .hoteliconssvg[index]
                                                      ['selected']
                                                  ? Colors.white
                                                  : AppColors.black
                                                      .withOpacity(0.3),
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
                    GetBuilder<DetailsController>(builder: (controller) {
                      return Handlingdataview(
                          statusrequest: controller.hotel == null
                              ? controller.statusrequest
                              : controller.updatehotelstatusrequest,
                          widget: NextButton(
                            title: controller.hotel == null
                                ? "add new hotel"
                                : "update information",
                            ontap: () async {
                              // String Iconscode = "";
                              if (controller.name!.text.isNotEmpty &&
                                  controller.location!.text.isNotEmpty &&
                                  controller.rating != "" &&
                                  controller.desc!.text.isNotEmpty) {
                                controller.iconscode = "";
                                for (int i = 0;
                                    i < controller.hoteliconssvg.length;
                                    i++) {
                                  if (controller.hoteliconssvg[i]['selected']) {
                                    controller.iconscode += '1';
                                  } else {
                                    controller.iconscode += '0';
                                  }
                                }
                                print(controller.rating);
                                print(controller.name!.text);
                                print(controller.location!.text);
                                print(controller.desc!.text);
                                await controller.hotel == null
                                    ? controller.addhoteldetails()
                                    : controller.updatehoteldetails(
                                        controller.hotel!.hotelLogo.toString());

                                // print(Iconscode);
                                // await controller.addhoteldetails();
                              } else {
                                Get.dialog(AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    CustomGroupButton(
                                        text: "Ok",
                                        ontap: () {
                                          Get.back();
                                        },
                                        color: AppColors.green)
                                  ],
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color: AppColors.red,
                                      ),
                                      Text(
                                        "Error",
                                        style: TextStyle(color: AppColors.red),
                                      )
                                    ],
                                  ),
                                  content: Text(
                                      "Make sure to add all information correctlly and select hotel logo"),
                                ));
                              }
                            },
                          ));
                    })
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
