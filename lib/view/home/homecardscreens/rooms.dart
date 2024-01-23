import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:booking/addroom.dart';
import 'package:booking/core/functions/animatedtransation.dart';
import 'package:booking/core/functions/deletedailogue.dart';
import 'package:booking/view/home/homecardscreens/rates.dart';
import 'package:booking/view/home/homecardscreens/users.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:booking/controller/home/groupcontroller.dart';
import 'package:booking/controller/home/roomcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:booking/view/widgets/room/addroomcard.dart';
import 'package:booking/view/widgets/rooms/addroomdialogue.dart';
import 'package:booking/view/widgets/rooms/roomgroupmealplan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_forest/flat_icons_medium.dart';
import 'package:icon_forest/kicons_emoji.dart';
import 'package:icon_forest/mbi_combi.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:icon_forest/icon_forest.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

  @override
  Widget build(BuildContext context) {
    RoomController controller = Get.put(RoomController());

    return Scaffold(
        appBar: CustomAppBar(pagetitle: "Rooms"),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getallrooms();
          },
          child: ListView(
            children: [
              CustomProfileCard(
                  image: ImageAssets.profile,
                  flag: ImageAssets.flag,
                  name: "ali salhab",
                  permition: "admin"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () async {
                            Navigator.of(context).push(createRoute(AddRoom()));

                            // Get.toNamed(AppRoutes.addroompage);
                            // await showaddroomDailogue(context);
                          },
                          child: Image.asset(ImageAssets.more)),
                      const Text("   Add Room")
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () async {
                            await showadddepartmentDailogue(context);
                          },
                          child: Image.asset(ImageAssets.more)),
                      const Text("   Add suited or department")
                    ],
                  ),
                ],
              ),
              GetBuilder<RoomController>(builder: (controller) {
                return Handlingdataview(
                    statusrequest: controller.uploadroomsstatusrequest,
                    widget: Column(
                      children: [
                        ...List.generate(controller.alladdedrooms.length,
                            (index) {
                          return RoomViewCard(
                            room: controller.alladdedrooms[index],
                          );
                        }),
                      ],
                    ));
              }),

              // box-shadow: 0px -2px 22px 0px #00000040;
              // ----------------------------------------above dialogue-----------------------------------------

              SizedBox(
                height: 4.h,
              ),
              IconButton(
                onPressed: () async {
                  await controller.getroomimages('33');
                },
                icon: Icon(Icons.abc),
              ),
            ],
          ),
        ));
  }
}

// ListView(
class RoomViewCard extends StatefulWidget {
  final RoomModel room;

  const RoomViewCard({super.key, required this.room});

  @override
  State<RoomViewCard> createState() => _RoomViewCardState();
}

class _RoomViewCardState extends State<RoomViewCard> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    RoomController controller = Get.find();
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
                                onTap: () {
                                  print("y");
                                  Get.to(
                                      AddRoom(
                                        room: widget.room,
                                      ),
                                      opaque: true,
                                      transition: Transition.circularReveal,
                                      duration: Duration(seconds: 1));
                                },
                                child: Container(
                                  width: 7.w,
                                  height: 7.w,
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
                                onTap: () async {
                                  print("tab delete room");
                                  showalertdeletedialogue(context, () async {
                                    await controller
                                        .deleteroom(widget.room.roomId!);
                                    Get.back();
                                  });
                                },
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
                            RoomGroupMealplanCard(
                              room: widget.room,
                            ),
                            Obx(() => controller.isfilteredobx.value
                                ? InkWell(
                                    onTap: () {
                                      controller.getalloptions(
                                          widget.room, () {});
                                      controller.update();

                                      controller.filteringgroupname = "";
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 3.w),
                                      decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(2.w)),
                                      child: Text(
                                        " ${controller.filternametoobx} filter applied \n    tap to reset",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container()),
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
