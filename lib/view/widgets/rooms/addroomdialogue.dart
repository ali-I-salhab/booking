import 'dart:io';
import 'dart:math';

import 'package:booking/controller/home/roomcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/core/functions/validinput.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/room/addroomcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

showadddepartmentDailogue(BuildContext context) {
  Get.delete<RoomController>(force: true);

  RoomController controller = Get.put(RoomController());
  // RoomController controller = Get.find();

  showDialog(
      context: context,
      builder: (x) {
        return Dialog(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: Text("Add suited or department")),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Rooms Count",
                      style: GoogleFonts.poppins(color: AppColors.blue),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UnconstrainedBox(
                      child: Container(
                        margin: EdgeInsets.only(left: 2.w),
                        // padding: EdgeInsets.only(
                        //     bottom: MediaQuery.of(context)
                        //         .viewInsets
                        //         .bottom),
                        width: 20.w,
                        height: 5.h,
                        child: TextFormField(
                          controller: controller.room_rate,
                          decoration: InputDecoration(
                            // suffixIcon: Icon(Ionicons.pricetag),
                            filled: true,
                            fillColor: AppColors.greytextformfield,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "   Rooms number",
                      style: TextStyle(color: AppColors.grey),
                    )
                  ],
                ),

                // MaterialButton(
                //     onPressed: () {
                //       controller.scrollDown();
                //     },
                //     child: Text("scrooll")),

                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Room Description"),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    child: TextFormField(
                      controller: controller.room_desc,
                      keyboardType: TextInputType.text,

                      // onEditingComplete: () {
                      //   FocusManager.instance.primaryFocus?.unfocus();
                      // },
                      maxLines: 5,
                      // controller: controller,
                      decoration: InputDecoration(
                        hintText: "Enter Room description",
                        filled: true,
                        fillColor: AppColors.greytextformfield,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )),
                Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                    height: 30.h,
                    width: 100.w,
                    // immages
                    child: GetBuilder<RoomController>(builder: (controller) {
                      return controller.roomphotos.isEmpty
                          ? Center(
                              child: InkWell(
                                onTap: () {
                                  showbottomsheet(() async {
                                    List<File> photos =
                                        await fileuploadgalllery();
                                    controller.roomphotos.addAll(photos);

                                    controller.update();
                                    Get.back(canPop: false);
                                  }, () async {
                                    File a = await imageuploadcamera();
                                    controller.roomphotos.add(a);
                                    controller.update();
                                    Get.back(canPop: false);
                                  });
                                  // Ge
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Ionicons.cloud_upload,
                                      color: AppColors.blue,
                                      size: 10.w,
                                    ),
                                    const Text("Upload Room images")
                                  ],
                                ),
                              ),
                            )
                          : ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...List.generate(
                                  controller.roomphotos.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      double x = 1;
                                      showDialog(
                                          context: context,
                                          builder: (v) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Container(
                                                width: 80.w,
                                                height: 70.h,
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                // color: AppColors.red,
                                                child: Transform.scale(
                                                    scale: 1,
                                                    child: Image.file(
                                                        fit: BoxFit.fill,
                                                        controller.roomphotos[
                                                            index])),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        height: 20.h,
                                        width: 20.h,
                                        color: AppColors.black,
                                        child: Image.file(
                                          controller.roomphotos[index],
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                )
                              ],
                            );
                    })),

                ...List.generate(3, (index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Room $index name"),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          child: TextFormField(
                            controller: controller.room_name,

                            // controller: controller,
                            decoration: InputDecoration(
                              hintText: "Enter Room name",
                              filled: true,
                              fillColor: AppColors.greytextformfield,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )),
                      Column(
                        children: [
                          ...List.generate(
                              controller.rooms.length,
                              (index) => AddRoomCard(
                                    index: index,
                                    onadd: () {
                                      print(controller.rooms);

                                      controller.rooms[index]['count'] += 1;
                                      controller.update();
                                    },
                                    onremove: () {
                                      controller.rooms[index]['count'] -= 1;
                                      controller.update();
                                    },
                                    title: controller.rooms[index]['room_type'],
                                    icon: Icons.bed,
                                    value: controller.rooms[index]['count'],
                                    cardtype: 'bed',
                                  ))
                        ],
                      ),
                    ],
                  );
                }),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Guests",
                    style: GoogleFonts.poppins(color: AppColors.blue),
                  ),
                ),
                Column(
                  children: [
                    ...List.generate(
                        controller.guests.length,
                        (index) => AddRoomCard(
                              index: index,
                              onadd: () {
                                print(controller.guests);
                                print("wdsdsd");
                                controller.guests[index]['count'] += 1;
                                controller.update();
                              },
                              onremove: () {
                                controller.guests[index]['count'] -= 1;
                                controller.update();
                              },
                              title: controller.guests[index]['guest_type'],
                              icon: controller.guests[index]['icon'],
                              value: controller.guests[index]['count'],
                              cardtype: 'guest',
                            ))
                  ],
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "curent rate",
                      style: GoogleFonts.poppins(color: AppColors.blue),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UnconstrainedBox(
                      child: Container(
                        margin: EdgeInsets.only(left: 2.w),
                        // padding: EdgeInsets.only(
                        //     bottom: MediaQuery.of(context)
                        //         .viewInsets
                        //         .bottom),
                        width: 20.w,
                        height: 5.h,
                        child: TextFormField(
                          controller: controller.room_rate,
                          decoration: InputDecoration(
                            // suffixIcon: Icon(Ionicons.pricetag),
                            filled: true,
                            fillColor: AppColors.greytextformfield,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "   set price ",
                      style: TextStyle(color: AppColors.grey),
                    )
                  ],
                ),
                // Avalibilty
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Availabitity",
                      style: GoogleFonts.poppins(color: AppColors.blue),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UnconstrainedBox(
                      child: Container(
                        margin: EdgeInsets.only(left: 2.w),
                        // padding: EdgeInsets.only(
                        //     bottom: MediaQuery.of(context)
                        //         .viewInsets
                        //         .bottom),
                        width: 20.w,
                        height: 5.h,
                        child: TextFormField(
                          controller: controller.room_availability,
                          decoration: InputDecoration(
                            // suffixIcon: Icon(Ionicons.pricetag),
                            filled: true,
                            fillColor: AppColors.greytextformfield,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "   number of available room",
                      style: TextStyle(color: AppColors.grey),
                    )
                  ],
                ),

                GetBuilder<RoomController>(builder: (controller) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: SizedBox(
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
                                          color: controller.hoteliconssvg[index]
                                                  ['selected']
                                              ? AppColors.blue
                                              : AppColors.greytextformfield),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            controller.hoteliconssvg[index]
                                                ['icon'],
                                            color:
                                                controller.hoteliconssvg[index]
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
                                                color: controller.hoteliconssvg[
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
                    ),
                  );
                }),
                GetBuilder<RoomController>(builder: (controller) {
                  return Handlingdataview(
                      statusrequest: controller.addroomsstatusrequest,
                      widget: Visibility(
                        replacement: CircularProgressIndicator(),
                        visible: controller.uploadcomplete,
                        child: SizedBox(
                          height: 9.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomGroupButton(
                                text: "save",
                                color: AppColors.green,
                                ontap: () async {
                                  await controller.addroom();
                                  Get.back(canPop: false);
                                  await controller.getallrooms();
                                },
                              ),
                              CustomGroupButton(
                                  ontap: () {
                                    print("ali");
                                    Get.back(canPop: false);
                                  },
                                  text: "Cancel",
                                  color: AppColors.red)
                            ],
                          ),
                        ),
                      ));
                })
              ],
            ),
          ),
        );
      });
}

showaddroomDailogue(BuildContext context) {
  // Get.delete<RoomController>(force: true);

  RoomController controller = Get.find();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  controller.cleardata();
  showDialog(
      context: context,
      builder: (x) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Dialog(
            child: Container(
              color: Colors.white,
              child: Material(
                child: Form(
                  key: formstate,
                  child: ListView(
                    children: [
                      // MaterialButton(
                      //     onPressed: () {
                      //       controller.scrollDown();
                      //     },
                      //     child: Text("scrooll")),
                      const Align(
                          alignment: Alignment.center, child: Text("Add Room")),

                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Room name"),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          child: TextFormField(
                            validator: (s) {
                              if (s!.isEmpty) {
                                // name is empty, don't validate
                                return 'errorEmptyField';
                              }
                              // print(s);
                              // return validate(s.toString(), 2, 15, "username");
                            },
                            controller: controller.room_name,

                            // controller: controller,
                            decoration: InputDecoration(
                              hintText: "Enter Room name",
                              filled: true,
                              fillColor: AppColors.greytextformfield,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Room Description"),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          child: TextFormField(
                            validator: (s) {
                              print(s);
                              return validate(s!, 2, 15, "username");
                            },
                            controller: controller.room_desc,
                            keyboardType: TextInputType.text,
                            onSaved: (s) {
                              print(s);
                            },
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Enter Room description",
                              filled: true,
                              fillColor: AppColors.greytextformfield,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 4.h),
                          // height: 30.h,
                          width: 100.w,
                          // immages
                          child:
                              GetBuilder<RoomController>(builder: (controller) {
                            return controller.roomlogo == null
                                ? Center(
                                    child: InkWell(
                                      onTap: () {
                                        showbottomsheet(() async {
                                          controller.roomlogo =
                                              await filesuploadgalllery();

                                          controller.update();
                                          Get.back(canPop: false);
                                        }, () async {
                                          File a = await imageuploadcamera();
                                          controller.roomlogo = a;
                                          controller.update();
                                          Get.back(canPop: false);
                                        });
                                        // Ge
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.cloud_upload,
                                            color: AppColors.blue,
                                            size: 10.w,
                                          ),
                                          const Text("Select Room main image")
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: Image.file(controller.roomlogo!),
                                  );
                          })),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 4.h),
                          // height: 30.h,
                          width: 100.w,
                          // immages
                          child:
                              GetBuilder<RoomController>(builder: (controller) {
                            return controller.roomphotos.isEmpty
                                ? Center(
                                    child: InkWell(
                                      onTap: () {
                                        showbottomsheet(() async {
                                          List<File> photos =
                                              await fileuploadgalllery();
                                          controller.roomphotos.addAll(photos);

                                          controller.update();
                                          Get.back(canPop: false);
                                        }, () async {
                                          File a = await imageuploadcamera();
                                          controller.roomphotos.add(a);
                                          controller.update();
                                          Get.back(canPop: false);
                                        });
                                        // Ge
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.cloud_upload,
                                            color: AppColors.blue,
                                            size: 10.w,
                                          ),
                                          const Text(
                                              "Select description images")
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 60.w,
                                    height: 20.h,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...List.generate(
                                          controller.roomphotos.length,
                                          (index) => InkWell(
                                            onTap: () {
                                              double x = 1;
                                              showDialog(
                                                  context: context,
                                                  builder: (v) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Container(
                                                        width: 80.w,
                                                        height: 70.h,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        // color: AppColors.red,
                                                        child: Transform.scale(
                                                            scale: 1,
                                                            child: Image.file(
                                                                fit:
                                                                    BoxFit.fill,
                                                                controller
                                                                        .roomphotos[
                                                                    index])),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2.w),
                                                height: 20.h,
                                                width: 20.h,
                                                color: AppColors.black,
                                                child: Image.file(
                                                  controller.roomphotos[index],
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                          })),
                      Column(
                        children: [
                          ...List.generate(
                              controller.rooms.length,
                              (index) => AddRoomCard(
                                    index: index,
                                    onadd: () {
                                      print(controller.rooms);

                                      controller.rooms[index]['count'] += 1;
                                      controller.update();
                                    },
                                    onremove: () {
                                      controller.rooms[index]['count'] -= 1;
                                      controller.update();
                                    },
                                    title: controller.rooms[index]['room_type'],
                                    icon: Icons.bed,
                                    value: controller.rooms[index]['count'],
                                    cardtype: 'bed',
                                  ))
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Guests",
                          style: GoogleFonts.poppins(color: AppColors.blue),
                        ),
                      ),
                      Column(
                        children: [
                          ...List.generate(
                              controller.guests.length,
                              (index) => AddRoomCard(
                                    index: index,
                                    onadd: () {
                                      print(controller.guests);
                                      print("wdsdsd");
                                      controller.guests[index]['count'] += 1;
                                      controller.update();
                                    },
                                    onremove: () {
                                      controller.guests[index]['count'] -= 1;
                                      controller.update();
                                    },
                                    title: controller.guests[index]
                                        ['guest_type'],
                                    icon: controller.guests[index]['icon'],
                                    value: controller.guests[index]['count'],
                                    cardtype: 'guest',
                                  ))
                        ],
                      ),

                      //

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "curent rate",
                            style: GoogleFonts.poppins(color: AppColors.blue),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          UnconstrainedBox(
                            child: Container(
                              margin: EdgeInsets.only(left: 2.w),
                              // padding: EdgeInsets.only(
                              //     bottom: MediaQuery.of(context)
                              //         .viewInsets
                              //         .bottom),
                              width: 20.w,
                              height: 5.h,
                              child: TextFormField(
                                controller: controller.room_rate,
                                onTap: () {},
                                decoration: InputDecoration(
                                  // suffixIcon: Icon(Ionicons.pricetag),
                                  filled: true,
                                  fillColor: AppColors.greytextformfield,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "   set price ",
                            style: TextStyle(color: AppColors.grey),
                          )
                        ],
                      ),
                      // Avalibilty
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Availabitity",
                            style: GoogleFonts.poppins(color: AppColors.blue),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          UnconstrainedBox(
                            child: Container(
                              margin: EdgeInsets.only(left: 2.w),
                              // padding: EdgeInsets.only(
                              //     bottom: MediaQuery.of(context)
                              //         .viewInsets
                              //         .bottom),
                              width: 20.w,
                              height: 5.h,
                              child: TextFormField(
                                controller: controller.room_availability,
                                onTap: () {},
                                decoration: InputDecoration(
                                  // suffixIcon: Icon(Ionicons.pricetag),
                                  filled: true,
                                  fillColor: AppColors.greytextformfield,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "   number of available room",
                            style: TextStyle(color: AppColors.grey),
                          )
                        ],
                      ),
                      GetBuilder<RoomController>(builder: (controller) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          child: SizedBox(
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
                                            print(controller.iconscode);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: controller.hoteliconssvg[
                                                        index]['selected']
                                                    ? AppColors.blue
                                                    : AppColors
                                                        .greytextformfield),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  controller
                                                          .hoteliconssvg[index]
                                                      ['icon'],
                                                  color:
                                                      controller.hoteliconssvg[
                                                              index]['selected']
                                                          ? Colors.white
                                                          : AppColors.black
                                                              .withOpacity(0.3),
                                                  width: 10.w,
                                                  height: 10.w,
                                                ),
                                                Text(
                                                  controller
                                                          .hoteliconssvg[index]
                                                      ['icon_name'],
                                                  style: TextStyle(
                                                      color: controller
                                                                  .hoteliconssvg[
                                                              index]['selected']
                                                          ? Colors.white
                                                          : AppColors.black
                                                              .withOpacity(
                                                                  0.3)),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                              ],
                            ),
                          ),
                        );
                      }),
                      GetBuilder<RoomController>(builder: (controller) {
                        return Handlingdataview(
                            statusrequest: controller.uploadcomplete
                                ? Statusrequest.loading
                                : Statusrequest.success,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomGroupButton(
                                  text: "save",
                                  color: AppColors.green,
                                  ontap: () async {
                                    print(formstate.currentState!.validate());
                                    if (formstate.currentState!.validate()) {
                                      print("valid input");
                                    }
                                    // controller.uploadcomplete = true;
                                    print(
                                        "-------------------------add rom dilaogue add button ");
                                    // await controller.addroom();
                                    // Get.back(canPop: false);
                                  },
                                ),
                                CustomGroupButton(
                                    ontap: () {
                                      print("ali");
                                      Get.back(canPop: false);
                                    },
                                    text: "Cancel",
                                    color: AppColors.red)
                              ],
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
