import 'package:booking/controller/home/groupcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/checkinternetconnection.dart';
import 'package:booking/core/services/services.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/addedgroup.dart';
import 'package:booking/view/widgets/groups/addgroupdialoge.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:country_list_picker/country_list_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:sizer/sizer.dart';
// import 'package:country_list_pick/country_list_pick.dart';

class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices ser = Get.find();
    GroupController controller = Get.put(GroupController());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(pagetitle: "Groups"),
        body: Obx(() => controller.enabled.value == true
            ? Container(
                child: ListView(
                  children: [
                    // CountryListPicker(),
                    Container(
                      // color: AppColors.blue,
                      child: Row(
                        children: [
                          Switch(
                              value: controller.enabled.value,
                              onChanged: (v) {
                                controller.enabled.value = v!;
                              }),
                          controller.enabled.value
                              ? Text("groups enabled ")
                              : Text("groups disaplled")
                        ],
                      ),
                    ),
                    CustomProfileCard(
                        image: ImageAssets.profile,
                        flag: ImageAssets.flag,
                        name: ser.shared.getString("email").toString(),
                        permition: "admin"),
                    InkWell(
                      onTap: () {
                        showaddgroupdialogue(context);
                        controller.addGroupSelectedCountrie = [];
                        controller.groupname!.text = "";
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageAssets.more,
                              width: 30.sp,
                              height: 30.sp,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text("New Guest Group"),
                          ],
                        ),
                      ),
                    ),
                    AddedGroups(),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.sp),
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Added guest group",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 24, color: Colors.white),
                      ),
                    ),
                    AddedGroupsview(),
                  ],
                ),
              )
            : Container(
                color: AppColors.red,
                child: Row(
                  children: [
                    Switch(
                        value: controller.enabled.value,
                        onChanged: (v) {
                          controller.enabled.value = v!;
                        }),
                    Text("Groups disabled")
                  ],
                ),
              )));
  }
}

class AddedGroups extends StatefulWidget {
  const AddedGroups({super.key});

  @override
  State<AddedGroups> createState() => _AddedGroupsState();
}

class _AddedGroupsState extends State<AddedGroups> {
  GroupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<GroupController>(builder: (controller) {
        return Handlingdataview(
            statusrequest: controller.uploadgroupsstatusrequest,
            widget: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: controller.alladdedgroups.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading:
                        Text(controller.alladdedgroups[index].name.toString()),
                    trailing: Checkbox(
                        value: controller.alladdedgroups[index].selected,
                        onChanged: (val) async {
                          setState(() {
                            controller.alladdedgroups[index].selected = val!;
                          });
                          await controller.updategroupstatus(
                              controller.alladdedgroups[index].id.toString(),
                              val!);
                        }),
                  );
                })));
      }),
    );
  }
}

class AddedGroupsview extends StatefulWidget {
  const AddedGroupsview({super.key});

  @override
  State<AddedGroupsview> createState() => _AddedGroupsviewState();
}

class _AddedGroupsviewState extends State<AddedGroupsview> {
  GroupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<GroupController>(builder: (controller) {
        return Handlingdataview(
            statusrequest: controller.uploadgroupsstatusrequest,
            widget: SizedBox(
              height: 30.h,
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.alladdedgroups.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: Text(
                            controller.alladdedgroups[index].name.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                print(
                                    controller.alladdedgroups[index].countries);
                                print(controller.alladdedgroups[index].name);
                                controller.addGroupSelectedCountrie =
                                    controller.alladdedgroups[index].countries;

                                controller.groupname!.text =
                                    controller.alladdedgroups[index].name;
                                showaddgroupdialogue(
                                  context,
                                  controller.alladdedgroups[index].id,
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.all(3.sp),
                                  decoration: BoxDecoration(
                                      color: AppColors.green,
                                      borderRadius: BorderRadius.circular(180)),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20.sp,
                                  )),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.all(1.w),
                                decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(180)),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () async {
                                String id = controller.alladdedgroups[index].id;
                                setState(() {
                                  controller.alladdedgroups.removeAt(index);

                                  controller.update();
                                });
                                if (!await checkinternetstatus()) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("no internet connection"),
                                        );
                                      });
                                } else {
                                  await controller.deletegroup(id);
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            ));
      }),
    );
  }
}

// SELECT * from countries WHERE countries.country_groupid in (SELECT group_id from groups WHERE groups.group_hotelid =22);
showaddgroupdialogue(context, [String id = ""]) {
  print(id);
  GroupController controller = Get.find();
  showDialog(
      context: context,
      builder: (u) {
        return Dialog(
          child: Container(
              padding: EdgeInsets.all(1.h),
              height: 90.h,
              width: 90.w,
              child: SizedBox(
                height: 50.h,
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "Add Guest Group",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add Group name",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                        child: TextFormField(
                      controller: controller.groupname,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.greytextformfield,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Nationalities in group",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<GroupController>(builder: (controller) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ]),
                        child: SizedBox(
                          height: 25.h,
                          child: Wrap(
                            children: [
                              ...List.generate(
                                  controller.addGroupSelectedCountrie.length,
                                  (index) => FittedBox(
                                        child: Chip(
                                          avatar: Icon(Icons.remove),
                                          label: FittedBox(
                                            child: Text(
                                              controller
                                                      .addGroupSelectedCountrie[
                                                  index],
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                          ),
                                        ),
                                      ))
                            ],
                          ).animate().flip(duration: Duration(seconds: 1)),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(" select Group nationalities"),
                    ),
                    GetBuilder<GroupController>(builder: (controller) {
                      return SizedBox(
                        height: 40.h,
                        width: 70.w,
                        child: Countrycard(),
                      );
                    }),
                    SizedBox(
                      height: 1.h,
                    ),
                    GetBuilder<GroupController>(builder: (controller) {
                      return Handlingdataview(
                          statusrequest: controller.addgroupsstatusrequest,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomGroupButton(
                                text: id == "" ? "Add" : "update",
                                ontap: () async {
                                  print("->${controller.groupname!.text}");
                                  if (controller.groupname!.text == "" ||
                                      controller
                                          .addGroupSelectedCountrie.isEmpty) {
                                    // print("ddddddddddddddddddemtyp");
                                    showDialog(
                                        context: context,
                                        builder: (c) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  color: AppColors.red,
                                                ),
                                                Text("Wrong !!")
                                              ],
                                            ),
                                            content: Text(
                                                "Enter group name \n Select at least one Country "),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              CustomGroupButton(
                                                  text: "ok",
                                                  ontap: () {
                                                    Get.back(canPop: false);
                                                  },
                                                  color: AppColors.green)
                                            ],
                                          );
                                        });
                                  } else {
                                    if (id == "") {
                                      await controller.addgroup();
                                      Get.back(canPop: false);
                                      await controller.getallgroups();
                                    } else {
                                      await controller.updategroup(id);
                                      Get.back(canPop: false);
                                      await controller.getallgroups();
                                    }
                                  }
                                },
                                color: AppColors.green,
                              ),
                              CustomGroupButton(
                                text: "cancel",
                                ontap: () {
                                  // controller.addGroupSelectedCountrie.clear();
                                  Get.back(canPop: false);
                                },
                                color: AppColors.red,
                              )
                            ],
                          ));
                    }),
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: countries.length,
                    //     itemBuilder: (c, index) {
                    //       String s;

                    //       return Text(countries[index].name);
                    //     })
                  ],
                ),
              )),
        );
      });
}

class Countrycard extends StatefulWidget {
  const Countrycard({super.key});

  @override
  State<Countrycard> createState() => _CountrycardState();
}

class _CountrycardState extends State<Countrycard> {
  GroupController controller = Get.find();

  List result = [];
  @override
  List<String> search(String query) {
    List<String> result = [];

    print("Query");
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].name.contains(RegExp(query, caseSensitive: false))) {
        result.add(countries[i].name);
      }
    }
    return result;
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
              Container(
                width: 40.w,
                child: TextFormField(
                  onTap: () {
                    print("tabbbed textfromfiled");
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (d) {
                    setState(() {
                      d.length == 0 ? result = [] : result = search(d);
                    });
                  },
                ),
              )
            ],
          ),
          Container(
              height: 20.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        result.length,
                        (index) => Container(
                              margin: EdgeInsets.all(5.sp),
                              padding: EdgeInsets.all(10.sp),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 12.sp,
                                      child: FittedBox(
                                          child: Text(result[index]))),
                                  Checkbox(
                                      value: controller.addGroupSelectedCountrie
                                              .contains(result[index])
                                          ? true
                                          : false,
                                      onChanged: (s) async {
                                        s == true
                                            ? controller
                                                .addGroupSelectedCountrie
                                                .add(result[index])
                                            : controller
                                                .addGroupSelectedCountrie
                                                .removeWhere((element) =>
                                                    element == result[index]);
                                        print("------------------------");
                                        print(controller
                                            .addGroupSelectedCountrie);
                                        controller.update();
                                      }),
                                ],
                              ),
                            ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
