import 'package:booking/controller/ratecontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/services/services.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/view/home/homecardscreens/update.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:booking/view/widgets/rooms/roomgroupmealplan.dart';
import 'package:booking/view/widgets/showaddrateavailability.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Rates extends StatelessWidget {
  const Rates({super.key});

  @override
  Widget build(BuildContext context) {
    Ratecontroller controller = Get.put(Ratecontroller());
    TextEditingController datecontroller = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(pagetitle: "Rates"),
      body: GetBuilder<Ratecontroller>(
        builder: (controller) {
          return Handlingdataview(
            statusrequest: controller.allpagestatus,
            widget: ListView(
              children: [
                CustomProfileCard(
                    image: ImageAssets.profile,
                    flag: ImageAssets.flag,
                    name: "ahmad",
                    permition: "admin"),
                Container(
                    // color: AppColors.black,

                    height: 70.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(controller.alladdedrooms.length,
                              (index) {
                            return RateViewCard(
                              room: controller.alladdedrooms[index],
                            );
                          }),
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}

showdeletedialog(context, data, index) {
  Ratecontroller controller = Get.find();
  showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          icon: Icon(Icons.dangerous),
          title: Text("Delete this period ?"),
          actions: [
            CustomGroupButton(
                text: "delete",
                ontap: () async {
                  await controller.deleterates(data[index]['id']);
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
}

showupdatedialogue(List data, context, index) {
  Ratecontroller controller = Get.find();
  controller.startdate!.value = data[index]['from'];
  controller.enddate!.value = data[index]['to'];
  controller.rate!.text = data[index]['rate'];
  controller.availability!.text = data[index]['availability'];
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showDatePicker(
                              onDatePickerModeChange: (x) {
                                print(x.name);
                                print("object");
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030))
                          .then((value) {
                        controller.startdate!.value =
                            value.toString().substring(0, 10);
                      });
                    },
                    child: Row(
                      children: [
                        Text("startdate :"),
                        Icon(Icons.date_range),
                        Obx(() {
                          return Text(controller.startdate!.value.toString());
                        })
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                              onDatePickerModeChange: (x) {
                                print(x.name);
                                print("object");
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2026))
                          .then((value) {
                        controller.enddate!.value =
                            value.toString().substring(0, 10);
                      });
                    },
                    child: Row(
                      children: [
                        Text("enddate :"),
                        Icon(Icons.date_range),
                        Obx(() {
                          return Text(controller.enddate!.value.toString());
                        })
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: CustomTextformfieldAuth(
                        title: " Rate",
                        mycontroller: controller.availability,
                        hint: "add Rate "),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: CustomTextformfieldAuth(
                        title: " availability",
                        mycontroller: controller.rate,
                        hint: "add availability"),
                  ),
                  GetBuilder<Ratecontroller>(builder: (controller) {
                    return Handlingdataview(
                        statusrequest: controller.addratestatusrequest,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomGroupButton(
                                text: "update",
                                ontap: () async {
                                  await controller.updaterateoravailability(
                                    controller.enddate!.value,
                                    controller.startdate!.value,
                                    data[index]['id'],
                                    controller.availability!.text,
                                    controller.rate!.text,
                                  );
                                },
                                color: AppColors.green),
                            Spacer(),
                            CustomGroupButton(
                                text: "cancel",
                                ontap: () {
                                  Get.back(canPop: false);
                                },
                                color: AppColors.red)
                          ],
                        ));
                  })
                ],
              ),
            ),
          ),
        );
      });
}

class RateViewCard extends StatefulWidget {
  // main in the screen
  final RoomModel room;
  const RateViewCard({super.key, required this.room});

  @override
  State<RateViewCard> createState() => _RoomViewCardState();
}

class _RoomViewCardState extends State<RateViewCard> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    Ratecontroller controller = Get.find();
    List svg = controller.getsvgfromiconcode(widget.room.roomIcons.toString());

    return Container(
        margin: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            // color: AppColors.red,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.8),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 4,
                  spreadRadius: 5)
            ]),
        child: Container(
          // height: 50.w,
          // width: 30.w,
          // color: Colors.yellow,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // color: Colors.green,
                      margin: EdgeInsets.all(1.w),
                      width: 20.w,
                      height: 25.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                            width: 5.h,
                            child: CachedNetworkImage(
                                width: 4.w,
                                height: 4.w,
                                fit: BoxFit.fill,
                                imageUrl: ImageAssets.networkroomphotos +
                                    "${widget.room.roomLogo}"),
                          ),
                          SizedBox(
                            height: 2.w,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(180),
                                    color: AppColors.blue,
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
                                onTap: () async {},
                                child: Container(
                                  width: 6.w,
                                  height: 6.w,
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
                      )),
                  Container(
                    // color: AppColors.blue,
                    width: 60.w,
                    margin: EdgeInsets.only(left: 1.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.room.roomName.toString(),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.room.roomDescEn.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(color: AppColors.grey),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: SizedBox(
                            width: 80.w,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                        svg.length,
                                        (index) => Container(
                                              margin: EdgeInsets.all(2),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.all(2),
                                                    height: 2.h,
                                                    width: 2.h,
                                                    child: SvgPicture.asset(
                                                        svg[index]),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 10.w,
                                                    child: Text(
                                                      controller.hoteliconssvg[
                                                          index]['icon_name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 5.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                child: status == true
                    ? Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RateGroupMealplanCard(
                              room: widget.room,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Material(
                                          child: Container(
                                            height: 35.h,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Select Mealplan"),
                                                    SizedBox(
                                                        height: 20.w,
                                                        child: Obx(
                                                          () => DropdownButton(
                                                              value: controller
                                                                          .filtermealplanname ==
                                                                      ""
                                                                  ? null
                                                                  : controller
                                                                      .filtermealplanname!
                                                                      .value,
                                                              items: controller
                                                                  .mealplans
                                                                  .map((e) => DropdownMenuItem(
                                                                      value: e
                                                                          .mealplanName,
                                                                      child: Text(e
                                                                          .mealplanName
                                                                          .toString())))
                                                                  .toList()
                                                                ..add(
                                                                    DropdownMenuItem(
                                                                  child: Text(
                                                                    "-",
                                                                  ),
                                                                  value: "",
                                                                )),
                                                              onChanged: (a) {
                                                                print("object");
                                                                print(a);
                                                                controller
                                                                        .filtermealplanname!
                                                                        .value =
                                                                    a.toString();
                                                              }),
                                                        ))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("Select group"),
                                                    SizedBox(
                                                        height: 20.w,
                                                        child: Obx(
                                                          () => Material(
                                                            child:
                                                                DropdownButton(
                                                                    value: controller.filtergroypname ==
                                                                            ""
                                                                        ? null
                                                                        : controller
                                                                            .filtergroypname!
                                                                            .value,
                                                                    items: controller
                                                                        .groups
                                                                        .map((e) => DropdownMenuItem(
                                                                            value:
                                                                                e,
                                                                            child: Text(e
                                                                                .toString())))
                                                                        .toList()
                                                                      ..add(
                                                                          DropdownMenuItem(
                                                                        child:
                                                                            Text(
                                                                          "-",
                                                                        ),
                                                                        value:
                                                                            "",
                                                                      )),
                                                                    onChanged:
                                                                        (a) {
                                                                      print(a
                                                                          .toString());
                                                                      controller
                                                                          .filtergroypname!
                                                                          .value = a.toString();
                                                                    }),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.isfiltered!
                                                        .value = true;
                                                    controller.isfiltered!
                                                        .value = false;
                                                    controller.isfiltered!
                                                        .value = true;
                                                    controller.filter(
                                                        widget.room,
                                                        group: controller
                                                            .filtergroypname!
                                                            .value
                                                            .toString(),
                                                        meal: controller
                                                            .filtermealplanname!
                                                            .value
                                                            .toString());

                                                    Get.back();
                                                  },
                                                  child: Text("Apply"),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Text("Apply filter")),
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              child: const Text(
                                "Show less >>",
                                style: TextStyle(color: AppColors.blue),
                              ),
                              onTap: () {
                                print('tabbed');
                                print(status);
                                setState(() {
                                  status = !status;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        child: const Text(
                          "Show More >>",
                          style: TextStyle(color: AppColors.blue),
                        ),
                        onTap: () {
                          print('tabbed');
                          print(status);
                          setState(() {
                            status = !status;
                          });
                        },
                      ),
              )
            ],
          ),
        ));
  }
}

class RateGroupMealplanCard extends StatelessWidget {
  final RoomModel room;

  const RateGroupMealplanCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    Ratecontroller controller = Get.find();

    return Container(
        width: 90.w,
        // height: 39.h,
        margin: EdgeInsets.only(bottom: 20.sp),
        padding: EdgeInsets.only(right: 20.sp),
        child: Stack(
          children: [
            Positioned(
              left: 15.w,
              child: Container(
                padding: EdgeInsets.all(5.sp),
                width: 80.w,
                margin: EdgeInsets.all(2.sp),
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Obx(() {
                      return controller.isfiltered.value
                          ? Row(
                              children: [
                                ...controller.filterresult,
                                SizedBox(
                                  width: 50.sp,
                                )
                              ],
                            )
                          : Row(
                              children: [
                                ...controller.alloptions,
                                SizedBox(
                                  width: 50.sp,
                                )
                              ],
                            );
                    })),
              ),
            ),
            Positioned(
              child: Container(
                width: 15.w,
                height: 35.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 90.sp,
                    ),
                    PhysicalModel(
                      elevation: 6.sp,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Container(
                        height: 4.h,
                        padding: EdgeInsets.all(2.sp),
                        child: Center(
                          child: FittedBox(child: Text("start date")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    PhysicalModel(
                      elevation: 6.sp,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Container(
                        height: 4.h,
                        padding: EdgeInsets.all(2.sp),
                        child: Center(
                          child: FittedBox(child: Text("end date")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    PhysicalModel(
                      elevation: 6.sp,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Container(
                        height: 4.h,
                        padding: EdgeInsets.all(2.sp),
                        child: Center(
                          child: FittedBox(child: Text("Current rate")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class Rategroupmeal extends StatelessWidget {
  final String groupname;
  final String periodstart;
  final String periodend;
  final String mealplan;
  List<String> Guests = [];
  List<String> Rooms = [];
  final RoomModel room;
  final void Function()? refresh;

  Rategroupmeal(
      {super.key,
      required this.groupname,
      required this.mealplan,
      required this.room,
      required this.periodstart,
      required this.periodend,
      this.refresh});

  @override
  Widget build(BuildContext context) {
    Ratecontroller controller = Get.put(Ratecontroller());

    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              controller.filter(room, group: groupname);
              controller.isfiltered.value = false;
              controller.isfiltered.value = true;
              controller.appliedfilter.value = groupname;
              print("filter by groupname");
            },
            child: controller.appliedfilter.value == groupname
                ? Container(
                    width: 50.w,
                    margin: EdgeInsets.symmetric(vertical: 5.sp),
                    padding: EdgeInsets.all(5.sp),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Center(
                        child: Text(
                      "$groupname",
                      style: TextStyle(fontSize: 12.sp),
                    )),
                  )
                : Container(
                    width: 50.w,
                    margin: EdgeInsets.symmetric(vertical: 5.sp),
                    padding: EdgeInsets.all(5.sp),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Center(
                        child: Text(
                      "$groupname",
                      style: TextStyle(fontSize: 12.sp),
                    )),
                  ),
          ),
          InkWell(
            onTap: () {
              controller.filter(room, meal: mealplan);
              controller.isfiltered.value = false;
              controller.isfiltered.value = true;
              controller.appliedfilter.value = mealplan;
              print("filter by mealplan");
            },
            child: Container(
              width: 50.w,
              margin: EdgeInsets.symmetric(vertical: 5.sp),
              padding: EdgeInsets.all(5.sp),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text(
                "$mealplan",
                style: TextStyle(fontSize: 12.sp),
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.sp),
            color: Color.fromARGB(255, 232, 121, 10).withOpacity(0.3),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Container(
                        height: 4.5.h,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                periodstart.substring(0, 10),
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white),
                              ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Container(
                        height: 4.5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              periodend.substring(0, 10),
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Container(
                        height: 4.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "12\$",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blue),
                                  onPressed: () {
                                    // showaddrateavailabilitydialogue(
                                    //     context, "Edit Rate", () {
                                    //   Get.back();
                                    // });
                                  },
                                  child: FittedBox(child: Text("edit Rate")),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
