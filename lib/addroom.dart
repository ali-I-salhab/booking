import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/controller/home/roomcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/showimagedialogue.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/core/functions/validinput.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/view/home/homecardscreens/users.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/room/addroomcard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class AddRoom extends StatelessWidget {
  final RoomModel? room;
  AddRoom({super.key, this.room});
  final formstate = GlobalKey<FormState>();
  RoomController controller = Get.find();
  List images = [];
  bool isinit = false;
  List<String> code = [];
  inint() async {
    for (int i = 0; i < room!.roomIcons!.length; i++) {
      if (room!.roomIcons![i] == "1")
        controller.hoteliconssvg[i]["selected"] = true;
    }

    controller.rooms[0]["count"] = int.parse(room!.roomExtralargbed!);
    controller.rooms[1]["count"] = int.parse(room!.roomSofabed!);
    controller.rooms[2]["count"] = int.parse(room!.roomBunkbed!);
    controller.rooms[3]["count"] = int.parse(room!.roomSinglebed!);
    controller.guests[0]['count'] = int.parse(room!.roomAdult!);
    controller.guests[1]['count'] = int.parse(room!.roomChildrenundersix!);
    controller.guests[2]['count'] = int.parse(room!.roomChildrenundertwelf!);
    controller.guests[3]['count'] = int.parse(room!.roomInfant!);

    controller.room_name!.text = room!.roomName!;
    controller.room_desc!.text = room!.roomDescEn!;
    controller.room_rate!.text = room!.roomRate!;
    controller.room_availability!.text = room!.roomAvailbility!;
    controller.roomlogo = await getimagefrom_url_as_file(
        url: ImageAssets.networkroomphotos + "${room!.roomLogo}");

    images = await controller.getroomimages(room!.roomId!);
    for (int i = 0; i < images.length; i++) {
      controller.roomphotos.add(await getimagefrom_url_as_file(
          url: ApiApplinks.roomimagesfolder + "${images[i]['photo_name']}"));
    }
    isinit = true;
    print("------------------------${room!.roomIcons!}");
    code = controller.getsvgfromiconcode(room!.roomIcons!);

    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    if (room != null && isinit == false) {
      print("init loading image data");
      inint();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formstate,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        room == null ? "Add Room" : "Edit room",
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      )),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Room name"),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: TextFormField(
                        controller: controller.room_name,
                        validator: (s) {
                          return validate(s.toString(), 3, 40, "roomname");

                          // print(s);
                          // return validate(s.toString(), 2, 15, "username");
                        },
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
                          return validate(s!, 5, 200, "roomdesc");
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                      // height: 30.h,
                      width: 100.w,
                      // immages
                      child: GetBuilder<RoomController>(builder: (controller) {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            : InkWell(
                                onTap: () {
                                  showimagedialogue(
                                      context,
                                      "",
                                      () {
                                        Get.back();
                                      },
                                      imagefiletoview: controller.roomlogo!,
                                      ondelete: () {
                                        controller.roomlogo = null;
                                        controller.update();
                                        Get.back();
                                      }).then((value) {
                                    if (value != null) {
                                      controller.roomlogo = value;
                                    }

                                    controller.update();
                                  });
                                },
                                child: UnconstrainedBox(
                                  child: Container(
                                    // color: Colors.red,
                                    height: 30.h,
                                    width: 15.h,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Transform.scale(
                                          scale: 1,
                                          child: Image.file(
                                            controller.roomlogo!,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                ),
                              );
                      })),
                  // here the section of descrition images
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                      // height: 30.h,
                      width: 100.w,
                      // immages
                      child: GetBuilder<RoomController>(builder: (controller) {
                        return !(room == null)
                            ? Container(
                                child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: controller.roomphotos.isEmpty
                                    ? Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 40.sp,
                                              width: 40.sp,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            Text("loading room images")
                                          ],
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          ...List.generate(
                                              controller.roomphotos.length,
                                              (index) => InkWell(
                                                    onTap: () {
                                                      showimagedialogue(
                                                          context,
                                                          "",
                                                          () {
                                                            Get.back();
                                                          },
                                                          imagefiletoview:
                                                              controller
                                                                      .roomphotos[
                                                                  index],
                                                          ondelete: () {
                                                            controller
                                                                .roomphotos
                                                                .removeAt(
                                                                    index);
                                                            controller.update();
                                                            Get.back();
                                                          }).then((value) {
                                                        print(value);
                                                        print(
                                                            "--------------------------------");
                                                        if (value != null) {
                                                          controller.roomphotos[
                                                              index] = value!;
                                                          controller.update();
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.sp),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black)),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    2.w),
                                                        height: 20.h,
                                                        width: 20.h,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                          child: Image.file(
                                                            controller
                                                                    .roomphotos[
                                                                index],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                  ))
                                            ..add(InkWell(
                                              onTap: () {
                                                showbottomsheet(() async {
                                                  List<File> photos =
                                                      await fileuploadgalllery();
                                                  controller.roomphotos
                                                      .addAll(photos);

                                                  controller.update();
                                                  Get.back(canPop: false);
                                                }, () async {
                                                  File a =
                                                      await imageuploadcamera();
                                                  controller.roomphotos.add(a);
                                                  controller.update();
                                                  Get.back(canPop: false);
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.w, right: 5.w),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 10.w,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "add more",
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.blue),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ))
                                        ],
                                      ),
                              ))
                            : controller.roomphotos.isEmpty
                                // here no images
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
                                // here the is selected images
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
                                              showimagedialogue(
                                                  context,
                                                  "",
                                                  () {
                                                    Get.back();
                                                  },
                                                  imagefiletoview: controller
                                                      .roomphotos[index],
                                                  ondelete: () {
                                                    controller.roomphotos
                                                        .removeAt(index);
                                                    controller.update();
                                                    Get.back();
                                                  }).then((value) {
                                                print(value);
                                                print(
                                                    "--------------------------------");
                                                if (value != null) {
                                                  controller.roomphotos[index] =
                                                      value!;
                                                  controller.update();
                                                }
                                              });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2.w),
                                                height: 20.h,
                                                width: 20.h,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  child: Image.file(
                                                    controller
                                                        .roomphotos[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ),
                                        )..add(InkWell(
                                            onTap: () {
                                              showbottomsheet(() async {
                                                List<File> photos =
                                                    await fileuploadgalllery();
                                                controller.roomphotos
                                                    .addAll(photos);

                                                controller.update();
                                                Get.back(canPop: false);
                                              }, () async {
                                                File a =
                                                    await imageuploadcamera();
                                                controller.roomphotos.add(a);
                                                controller.update();
                                                Get.back(canPop: false);
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.w, right: 5.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 10.w,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "add more",
                                                    style: TextStyle(
                                                        color: AppColors.blue),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                      ],
                                    ),
                                  );
                      })),

                  // here the end of description images
                  Align(
                    alignment: Alignment.center,
                    child: Text("Beds",
                        style: GoogleFonts.poppins(
                            color: AppColors.blue, fontSize: 24.sp)),
                  ),
                  Divider(
                    thickness: 2.sp,
                  ),
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
                    child: Text("Guests",
                        style: GoogleFonts.poppins(
                            color: AppColors.blue, fontSize: 24.sp)),
                  ),
                  Divider(
                    thickness: 2.sp,
                  ),
                  Column(
                    children: [
                      ...List.generate(
                          controller.guests.length,
                          (index) => AddRoomCard(
                                index: index,
                                onadd: () {
                                  print(controller.guests);

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
                            keyboardType: TextInputType.number,
                            validator: (s) {
                              return validate(s.toString(), 3, 12, "numrate");

                              // print(s);
                              // return validate(s.toString(), 2, 15, "username");
                            },
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
                            keyboardType: TextInputType.number,
                            validator: (s) {
                              return validate(
                                  s.toString(), 3, 12, "numavailabilty");

                              // print(s);
                              // return validate(s.toString(), 2, 15, "username");
                            },
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
                              text: room == null ? "save" : "update",
                              color: AppColors.green,
                              ontap: () async {
                                if (controller.roomlogo == null) {
                                  print("111");
                                  Get.snackbar(
                                      "Error", "please select  room logo");
                                  return;
                                }
                                if (room == null &&
                                    controller.roomphotos.length == 0) {
                                  print("1112222222");
                                  Get.snackbar("Error",
                                      "please select at least one room image");
                                  return;
                                }
                                bool isd = false;
                                for (int i = 0;
                                    i < controller.hoteliconssvg.length;
                                    i++) {
                                  if (controller.hoteliconssvg[i]['selected']) {
                                    isd = true;
                                    break;
                                  }
                                }
                                if (!isd) {
                                  Get.snackbar("Error",
                                      "please select at least one room image");
                                  return;
                                }
                                if (formstate.currentState!.validate()) {
                                  print("add room");
                                  room == null
                                      ? await controller.addroom()
                                      : await controller.updateroom(
                                          room!.roomId!, room!.roomLogo!);
                                  // Get.back(canPop: false);
                                }
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
  }
}
