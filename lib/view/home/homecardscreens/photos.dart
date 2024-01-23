import 'dart:io';

import 'package:booking/controller/home/photoscontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/deletedailogue.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/showimagedialogue.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/nextbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Photos extends StatelessWidget {
  const Photos({super.key});

  @override
  Widget build(BuildContext context) {
    PhotosController controller = Get.put(PhotosController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(pagetitle: "Photos"),
        body: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(color: AppColors.green),
                child: Text(
                  "Uploaded Images",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 20.sp),
                )),
            GetBuilder<PhotosController>(builder: ((controller) {
              return Handlingdataview(
                  ontap: () async {
                    await controller.showuploadedphotos();
                  },
                  statusrequest: controller.statusrequest,
                  widget: UnconstrainedBox(
                    child: SizedBox(
                      height: 60.h,
                      width: 100.w,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.photosview.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                File? a;
                                a = await showimagedialogue(
                                        context,
                                        ImageAssets.networkhotelphotos +
                                            "${controller.photosview[index].photoName}",
                                        () async {})
                                    .then((value) async {
                                  if (value != null) {
                                    await controller.updatephoto(
                                        value!,
                                        controller.photosview[index].photoId!,
                                        controller
                                            .photosview[index].photoName!);
                                    Get.back();
                                  }
                                });

                                print(
                                    "---------------------------------------------------------");

                                // if (a != null) {
                                //   print(a.path);
                                //   await controller.updatephoto(
                                //       a,
                                //       controller.photosview[index].photoId!,
                                //       controller.photosview[index].photoName!);
                                // }
                              },
                              onLongPress: () {
                                showalertdeletedialogue(context, () async {
                                  controller.deletephoto(
                                      controller.photosview[index].photoId!,
                                      controller.photosview[index].photoName!);

                                  Get.back(canPop: false);
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5.sp),
                                    height: 70.h,
                                    width: 35.h,
                                    padding: EdgeInsets.all(5.sp),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(20.sp)),
                                    // color: AppColors.red,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              UnconstrainedBox(
                                                child: Container(
                                                  width: 3.h,
                                                  height: 3.h,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                          imageUrl: ImageAssets
                                                  .networkhotelphotos +
                                              "${controller.photosview[index].photoName}"),
                                    ),
                                  ),
                                  Positioned(
                                      top: 20.sp,
                                      right: 20.sp,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.blue,
                                            borderRadius:
                                                BorderRadius.circular(4.sp)),
                                        padding: EdgeInsets.all(10.sp),
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }),
                    ),
                  ));
            })),
            InkWell(
              onTap: () {
                showbottomsheet(() async {
                  controller.photos = await fileuploadgalllery();
                  // controller.photos.add(x);

                  controller.update();
                  Get.back(canPop: false);
                }, () async {
                  File a = await imageuploadcamera();
                  controller.photos.add(a);
                  controller.update();
                  Get.back(canPop: false);
                });
                // Get.snackbar("title", "message");
                // Get.bottomSheet(Text(""));
              },
              child: Container(
                alignment: Alignment.center,
                height: 10.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_upload_outlined),
                    Text("Upload images"),
                  ],
                ),
              ),
            ),
            GetBuilder<PhotosController>(
                builder: (controller) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        child: Row(
                          children: [
                            ...List.generate(
                                controller.photos.length,
                                (index) => Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.black.withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: EdgeInsets.only(
                                        left: 1.w,
                                        right: 1.w,
                                      ),
                                      width: 30.w,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            // bottom: 0,
                                            // left: 0,
                                            child: Container(
                                              height: 35.h,
                                              width: 40.w,
                                              // padding: EdgeInsets.all(1.w),
                                              // decoration: BoxDecoration(color: Colors.amber),
                                              margin: EdgeInsets.all(10.sp),
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    controller.photos[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 1.h,
                                              right: 7.w,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.photos
                                                          .removeAt(index);
                                                      controller.update();
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.w),
                                                      decoration: BoxDecoration(
                                                          color: AppColors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      padding:
                                                          EdgeInsets.all(2.sp),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      print("edit image");
                                                      File cropped;

                                                      cropped = await cropImage(
                                                          controller
                                                              .photos[index]!,
                                                          context);
                                                      controller.photos[index] =
                                                          cropped;
                                                      controller.update();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      padding:
                                                          EdgeInsets.all(2.sp),
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ))
                          ],
                        ),
                      ),
                    )),
            GetBuilder<PhotosController>(builder: (controller) {
              return controller.photos.length == 0
                  ? Container()
                  : NextButton(
                      title: "Upload images",
                      ontap: () async {
                        await controller.uploadphotos();
                        await controller.showuploadedphotos();
                        // await controller.uploadphotos();

                        print(controller.photos.length);
                      },
                    );
            }),
          ],
        ));
  }
}
