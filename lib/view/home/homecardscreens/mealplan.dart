import 'dart:math';

import 'package:booking/controller/home/mealplancontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/checkinternetconnection.dart';
import 'package:booking/core/functions/validinput.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MealPlan extends StatelessWidget {
  const MealPlan({super.key});

  @override
  Widget build(BuildContext context) {
    MealplanControlle controller = Get.put(MealplanControlle());
    return Scaffold(
      appBar: CustomAppBar(pagetitle: "MealPlans"),
      body: SafeArea(
        child: ListView(
          children: [
            CustomProfileCard(
                image: ImageAssets.profile,
                flag: ImageAssets.flag,
                name: "ali",
                permition: "permition"),
            Obx(
              () => Switch(
                  value: controller.enable.value,
                  onChanged: (d) {
                    print("object");
                    controller.enable.value = d;
                  }),
            ),
            Obx(() => controller.enable.value
                ? Column(
                    children: [
                      Text(
                        "Hotel Meal Plan",
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: 30.h,
                          child: GetBuilder<MealplanControlle>(
                              builder: (controller) => Handlingdataview(
                                    statusrequest: controller.statusrequest,
                                    widget: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 10.sp),
                                      decoration: BoxDecoration(
                                          color: AppColors.black
                                              .withOpacity(0.07)),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ...List.generate(
                                              controller.mealplans.length,
                                              (index) => InkWell(
                                                    onTap: () async {
                                                      controller.mealplans
                                                          .removeAt(index);
                                                      await controller
                                                          .deletemealplan(
                                                              controller
                                                                  .mealplans[
                                                                      index]
                                                                  .mealplanId!);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.all(5.sp),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: ListTile(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          title: Text(controller
                                                              .mealplans[index]
                                                              .mealplanName!),
                                                          subtitle: Text(
                                                              controller
                                                                  .mealplans[
                                                                      index]
                                                                  .mealplanDesc!
                                                                  .trim()),
                                                          trailing: GetBuilder<
                                                                  MealplanControlle>(
                                                              builder:
                                                                  (controller) {
                                                            return Checkbox(
                                                                value: controller
                                                                            .mealplans[
                                                                                index]
                                                                            .mealplanStatus ==
                                                                        "1"
                                                                    ? true
                                                                    : false,
                                                                onChanged:
                                                                    (s) async {
                                                                  if (controller
                                                                          .mealplans[
                                                                              index]
                                                                          .mealplanStatus ==
                                                                      '1') {
                                                                    controller
                                                                        .mealplans[
                                                                            index]
                                                                        .mealplanStatus = "0";
                                                                  } else {
                                                                    controller
                                                                        .mealplans[
                                                                            index]
                                                                        .mealplanStatus = "1";
                                                                  }

                                                                  controller.updatemealplanstatus(
                                                                      controller
                                                                          .mealplans[
                                                                              index]
                                                                          .mealplanId!,
                                                                      s!);
                                                                  // await controller
                                                                  //     .viewmealplans();
                                                                  controller
                                                                      .update();
                                                                });
                                                          })),
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ))),
                      InkWell(
                        onTap: () {
                          controller.mealplanname!.text = "";
                          controller.mealplandesc!.text = "";
                          showaddmealplandialog(context, () async {
                            if (controller.formstate.currentState!.validate()) {
                              await controller.addmealplan();
                              Get.back();
                              await controller.viewmealplans();
                            }
                          }, () {
                            Get.back();
                          }, () async {
                            // await controller.updatemealplan();
                            Get.back();
                            await controller.viewmealplans();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(ImageAssets.more),
                            ),
                            Text("    Add more mail plans")
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 30.h,
                          child: GetBuilder<MealplanControlle>(
                              builder: (controller) {
                            return Handlingdataview(
                                statusrequest: controller.statusrequest,
                                widget: Container(
                                  color: AppColors.black.withOpacity(0.09),
                                  padding: EdgeInsets.all(10.sp),
                                  margin: EdgeInsets.all(10.sp),
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      ...List.generate(
                                          controller.mealplans.length,
                                          (index) => Addedmealplans(
                                                ondelete: () async {
                                                  await controller
                                                      .deletemealplan(controller
                                                          .mealplans[index]
                                                          .mealplanId!);
                                                  await controller
                                                      .viewmealplans();
                                                  controller.mealplans
                                                      .removeAt(index);
                                                },
                                                onedit: () {
                                                  controller
                                                          .mealplanname!.text =
                                                      controller
                                                          .mealplans[index]
                                                          .mealplanName!;
                                                  controller
                                                          .mealplandesc!.text =
                                                      controller
                                                          .mealplans[index]
                                                          .mealplanDesc!;
                                                  print(
                                                      "object:${controller.mealplans[index].mealplanDesc}");
                                                  showaddmealplandialog(
                                                      context, () {}, () {
                                                    Get.back(canPop: false);
                                                  }, () {
                                                    controller.updatemealplan(
                                                        controller
                                                            .mealplans[index]
                                                            .mealplanId!);
                                                  },
                                                      controller
                                                          .mealplans[index]
                                                          .mealplanId!);
                                                },
                                                name: controller
                                                    .mealplans[index]
                                                    .mealplanName!,
                                              ))
                                    ],
                                  ),
                                ));
                          }))
                      // checkinternetstatus()
                    ],
                  )
                : Center(
                    child: Text(
                      "Meal plans Dispabled",
                      style: TextStyle(color: AppColors.red),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

class Addedmealplans extends StatelessWidget {
  final String name;
  final void Function()? onedit;
  final void Function()? ondelete;
  final void Function()? onview;

  const Addedmealplans(
      {super.key, required this.name, this.onedit, this.ondelete, this.onview});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.green.withOpacity(0.11)),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Row(
            children: [
              InkWell(
                onTap: onedit,
                child: Container(
                  width: 7.w,
                  height: 7.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: AppColors.green,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              InkWell(
                onTap: ondelete,
                child: Container(
                  width: 7.w,
                  height: 7.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: AppColors.red,
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 15.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

showaddmealplandialog(context, GestureTapCallback onadd,
    void Function() oncancel, GestureTapCallback onedit,
    [String id = ""]) {
  print(id);
  MealplanControlle controller = Get.find();
  showDialog(
      context: context,
      builder: (s) {
        return UnconstrainedBox(
          child: Container(
            color: AppColors.primarycolor,
            width: 80.w,
            height: 50.h,
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    children: [
                      CustomTextformfieldAuth(
                          valid: (x) {
                            return validate(x.toString(), 4, 15, "username");
                          },
                          title: "Meal plan name",
                          mycontroller: controller.mealplanname,
                          hint: "meal plan name"),
                      CustomTextformfieldAuth(
                          valid: (x) {
                            return validate(x.toString(), 10, 30, "username");
                          },
                          maxlines: 5,
                          title: "Meal plan description",
                          mycontroller: controller.mealplandesc,
                          hint: "meal plan name"),
                      GetBuilder<MealplanControlle>(builder: (controller) {
                        return Handlingdataview(
                            statusrequest: id == ""
                                ? controller.addstatusrequest
                                : controller.updatestatusrequest,
                            widget: Container(
                              margin: EdgeInsets.all(2.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomGroupButton(
                                      text: id == "" ? "add" : "update",
                                      ontap: id == "" ? onadd : onedit,
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
          ),
        );
      });
}
