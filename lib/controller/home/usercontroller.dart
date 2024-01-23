import 'dart:io';

import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/mealplans/mealplandata.dart';
import 'package:booking/data/datasource/remote/homepage/users/usersdata.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/mealplanmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usercontroller extends GetxController {
  List hoteliconssvg = [
    {"icon_name": "Dtails", "icon": ImageAssets.details, "selected": false},
    {"icon_name": "photos", "icon": ImageAssets.photos, "selected": false},
    {"icon_name": "Guest groups", "icon": ImageAssets.group, "selected": false},
    {
      "icon_name": "meal plans",
      "icon": ImageAssets.mealplan,
      "selected": false
    },
    {"icon_name": "payment", "icon": ImageAssets.payment, "selected": false},
    {"icon_name": "rooms", "icon": ImageAssets.rooms, "selected": false},
    {"icon_name": "Rates", "icon": ImageAssets.rates, "selected": false},
    {
      "icon_name": "availability",
      "icon": ImageAssets.available,
      "selected": false
    },
    {"icon_name": "users", "icon": ImageAssets.users, "selected": false},
  ];
  RxBool enable = true.obs;
  File? userprofileimage;
  List<MealPlanModel> mealplans = [];
  HotelModel? hotel;
  List users = [];
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest addstatusrequest = Statusrequest.none;

  TextEditingController? username;
  TextEditingController? email;

  TextEditingController? passwword;

  TextEditingController? userdesc;
  TextEditingController? phone;

  String userpermitioncode = "000000000";

  UsersData usersData = UsersData(Get.find());
  generatecode() {
    String code = "";
    for (int i = 0; i < hoteliconssvg.length; i++) {
      if (hoteliconssvg[i]['selected'] == true) {
        code += '1';
      } else {
        code += '0';
      }
    }
    return code;
  }

  addusers() async {
    userpermitioncode = "";
    userpermitioncode = generatecode();
    print(
        "-----------------------add user -----------------$userpermitioncode");
    addstatusrequest = Statusrequest.loading;
    update();

    var response = await usersData.usersadd(
        hotel!.hotelId.toString(),
        username!.text,
        userpermitioncode!,
        email!.text,
        phone!.text,
        passwword!.text,
        userdesc!.text,
        userprofileimage!);
    print("response =================> $response");
    addstatusrequest = handlingdata(response);
    update();

    if (addstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        addstatusrequest = Statusrequest.success;

        Get.back(canPop: false);
        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        addstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  viewusers() async {
    mealplans.clear();
    statusrequest = Statusrequest.loading;
    update();

    var response = await usersData.usersview(hotel!.hotelId.toString());
    print("response =================> $response");
    statusrequest = handlingdata(response);
    update();
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        users = d;
        print(users);

        statusrequest = Statusrequest.success;
        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        statusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  deleteuser(String id) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await usersData.usersdelete(id);
    print("response =================> $response");
    statusrequest = handlingdata(response);
    update();
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        statusrequest = Statusrequest.success;

        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        statusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  @override
  void onInit() async {
    hotel = Get.arguments['hotel'];
    username = TextEditingController();
    userdesc = TextEditingController();
    email = TextEditingController();

    passwword = TextEditingController();

    phone = TextEditingController();

    await viewusers();

    // TODO: implement onInit
    super.onInit();
  }
}
