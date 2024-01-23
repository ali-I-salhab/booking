import 'package:booking/controller/home/authaccountcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UnderyourAccount extends StatelessWidget {
  List<HotelModel> hotelmodel;
  UnderyourAccount({
    super.key,
    required this.title,
    required this.images,
    required this.ontapadd,
    required this.hotelmodel,
  });
  final String title;
  final List<String> images;
  final void Function()? ontapadd;

  // void Function

  @override
  Widget build(BuildContext context) {
    AuthaccountinfoController controller = Get.find();
    return Container(
      margin: EdgeInsets.all(1.w),
      // color: AppColors.primarycolor,
      // height: 13.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: ontapadd,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  height: 5.h,
                  // width: 5.h,
                  child: Image.asset(ImageAssets.more),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                child: Text(
                  "$title",
                  style: TextStyle(fontSize: 19.sp),
                ),
              ),
            ],
          ),
          GetBuilder<AuthaccountinfoController>(builder: (controller) {
            return Handlingdataview(
                ontap: () async {
                  await controller.gethotels();
                },
                statusrequest: controller.statusrequest,
                widget: Container(
                  // color: AppColors.green,
                  height: 10.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 90.w,
                        height: 20.h,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                                hotelmodel.length,
                                (index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: GestureDetector(
                                            onLongPress: () {
                                              print(
                                                  "dddddddddddddddddddddddddd");
                                              Get.dialog(AlertDialog(
                                                title: Row(
                                                  children: [
                                                    Text("Delet hotel ??"),
                                                    Icon(Ionicons.alert)
                                                  ],
                                                ),
                                                actions: [
                                                  CustomGroupButton(
                                                    text: 'Delete',
                                                    ontap: () async {
                                                      await controller
                                                          .deletehotels(
                                                              controller
                                                                  .hotels[index]
                                                                  .hotelId
                                                                  .toString(),
                                                              controller
                                                                  .hotels[index]
                                                                  .hotelLogo
                                                                  .toString());
                                                    },
                                                    color: AppColors.green,
                                                  ),
                                                  CustomGroupButton(
                                                    text: 'cancel',
                                                    ontap: () {
                                                      Get.back();
                                                    },
                                                    color: AppColors.red,
                                                  )
                                                ],
                                              ));
                                            },
                                            child: Container(
                                              // width: 20.w,
                                              padding: EdgeInsets.all(1.1.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppColors.blue
                                                      .withOpacity(0.1)),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  // color: AppColors.black,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        // margin: EdgeInsets.only(right: 1.w),
                                                        // height: 9.h,
                                                        // width: 9.h,
                                                        // decoration: BoxDecoration(
                                                        //     borderRadius: BorderRadius.circular(180),
                                                        //     color: AppColors.blue,
                                                        //     image: DecorationImage(
                                                        //         fit: BoxFit.fill,
                                                        //         image: AssetImage(images[index]))),

                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              "https://alisalhabqq11.000webhostapp.com/upload/hotellogo/${hotelmodel[index].hotelLogo!}",
                                                          // height: 8.h,
                                                          placeholder: (context,
                                                                  url) =>
                                                              UnconstrainedBox(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            child: Text(hotelmodel[
                                                                    index]
                                                                .hotelName!
                                                                .toString()))),
                                                  ]),
                                            ),
                                            onTap: () {
                                              print(
                                                  hotelmodel[index].hotelName);
                                              Get.toNamed(AppRoutes.homepage,
                                                  arguments: {
                                                    "hotel": hotelmodel[index]
                                                  });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.w),
                                          // color: AppColors.blue,
                                          height: 10.h,
                                          width: 0.5.w,
                                        )
                                      ],
                                    ))
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          })
        ],
      ),
    );
  }
}
