import 'package:booking/controller/home/roomcontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/view/widgets/showaddrateavailability.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class RoomGroupMealplanCard extends StatelessWidget {
  final RoomModel room;
  RoomGroupMealplanCard({super.key, required this.room});

  RoomController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90.w,
        height: 44.h,
        child: Stack(
          children: [
            Positioned(
                left: 15.w,
                child: Container(
                    width: 80.w,
                    margin: EdgeInsets.only(right: 50.sp),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      // child: Text("sdsd"),
                      child: Obx(() {
                        return (controller.isfiltered!.value == false)
                            ? Row(
                                children: controller.getalloptions(room),
                              )
                            : Row(
                                children: controller.filterresult,
                              );
                      }),
                    ))),
            Positioned(
              child: Container(
                width: 15.w,
                height: 40.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 33.sp,
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                      elevation: 6.sp,
                      shadowColor: Colors.black,
                      child: Container(
                        height: 8.h,
                        padding: EdgeInsets.all(2.sp),
                        child: Center(
                          child: FittedBox(child: Text("Guests")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    PhysicalModel(
                      elevation: 6.sp,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Container(
                        height: 8.h,
                        padding: EdgeInsets.all(2.sp),
                        child: Center(
                          child: FittedBox(child: Text("beds")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.5.sp,
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
                          child: FittedBox(child: Text("mealplans")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.sp,
                    ),
                    Container(
                      child: PhysicalModel(
                        elevation: 6.sp,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.sp),
                        child: Container(
                          height: 4.h,
                          padding: EdgeInsets.all(2.sp),
                          child: Center(
                            child: FittedBox(child: Text("Availability")),
                          ),
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

class Roomgroupmeal extends StatelessWidget {
  final String groupname;
  final String groupid;
  final String mealplan;
  final String mealplanid;
  List<String> Guests = [];
  List<String> Rooms = [];
  final RoomModel room;

  Roomgroupmeal({
    super.key,
    required this.groupname,
    required this.mealplan,
    required this.room,
    required this.groupid,
    required this.mealplanid,
  });

  @override
  Widget build(BuildContext context) {
    RoomController controller = Get.put(RoomController());

    return Container(
      padding: EdgeInsets.only(right: 20.sp),
      child: Column(
        children: [
          Container(
            width: 50.w,
            margin: EdgeInsets.symmetric(vertical: 5.sp),
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
                child: Text(
              "$groupname",
              style: TextStyle(
                  color: controller.groups.length == 0
                      ? Colors.red
                      : Colors.black),
            )),
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
                      SizedBox(
                        width: 50.w,
                        height: 8.h,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // physics: NeverScrollableScrollPhysics(),
                            children: [
                              ...List.generate(
                                  controller.guests.length,
                                  (index) => Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 3.sp),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 1.w,
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              FittedBox(
                                                child: Text(
                                                  controller.guests[index]
                                                      ['guest_type'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8.sp),
                                                ),
                                              ),
                                              FittedBox(
                                                  child: Text(room.roomAdult
                                                      .toString()))
                                            ],
                                          ),
                                        ),
                                      )),
                            ]),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                        padding: EdgeInsets.symmetric(vertical: 1.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  height: 8.h,
                                  child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      // physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        ...List.generate(
                                          controller.rooms.length,
                                          (index) => Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.sp),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 1.w,
                                                vertical: 5.sp),
                                            child: FittedBox(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    controller.rooms[index]
                                                        ['room_type'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10.sp),
                                                  ),
                                                  Text(
                                                      room.roomAdult.toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10.sp))
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                )
                              ],
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23)),
                        child: Center(
                          child: Text(
                            "$mealplan",
                            style: GoogleFonts.poppins(
                                color: controller.mealplans.length == 0
                                    ? Colors.red
                                    : Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Container(
                        height: 3.5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(controller.availabilitymap[(
                              room.roomId,
                              mealplanid,
                              groupid,
                            )]
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 2.h),
                      ),
                      Container(
                        height: 3.5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("12")],
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 50.w,
                        color: Colors.white,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor: AppColors.blue),
                          //   onPressed: () {},
                          //   child: Text("add Rate"),
                          // ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue),
                            onPressed: () {
                              controller.availabilityval!.text =
                                  controller.availabilitymap[(
                                room.roomId,
                                mealplanid,
                                groupid,
                              )];
                              showaddrateavailabilitydialogue(context, "add",
                                  () async {
                                await controller.updateavailability(
                                    groupid,
                                    mealplanid,
                                    controller.availabilityval!.text);
                                print("editing complete");

                                print(controller.availabilityval!.text);
                                Get.back();
                              }, controller.availabilityval!);
                            },
                            child: Text("add Availabiltiy"),
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
    );
  }
}
