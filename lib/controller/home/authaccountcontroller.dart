import 'dart:io';

import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/core/services/services.dart';
import 'package:booking/data/datasource/remote/homepage/authpagedata.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthaccountinfoController extends GetxController {
  List<HotelModel> hotels = [];
  final RxString countryname = "egypt".obs;
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest deletehotelstatusrequest = Statusrequest.none;

  AuthData authData = AuthData(Get.find());
  MyServices services = Get.find();
  final RxString countryflag = "".obs;
  @override

  // routers
  gotogooglemap() {
    Get.toNamed(AppRoutes.googlemap);
  }

  gotohoteldetails() {
    Get.toNamed(AppRoutes.hoteldetails);
  }

  gotomoreinfo() {
    Get.toNamed(AppRoutes.moreinfo);
  }

  gotohomepage() {
    Get.offAllNamed(AppRoutes.homepage);
  }

  deletehotels(String hotelid, String oldimagename) async {
    deletehotelstatusrequest = Statusrequest.loading;
    update();
    var response = await authData.deletehote(hotelid, oldimagename);

    deletehotelstatusrequest = handlingdata(response);

    if (deletehotelstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print("here response is $response");
        deletehotelstatusrequest = Statusrequest.success;
        update();

        print(response['data']);
      }
    } else {
      // Get.defaultDialog(title: "42".tr, middleText: "44".tr);

      deletehotelstatusrequest = Statusrequest.offlinefailure;

      update();
    }
  }

  gethotels() async {
    hotels = [];
    statusrequest = Statusrequest.loading;
    update();
    var response;
    try {
      response = await authData.hotelview(services.shared.getString("id")!);
    } catch (e) {
      print(e);
    }

    print("response =================> $response");
    statusrequest = handlingdata(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        hotels.addAll(d.map((e) => HotelModel.fromJson(e)));
      } else {
        Get.snackbar("Warning", "No data found");

        statusrequest = Statusrequest.failure;

        update();
      }
    } else {
      Get.snackbar("Connection error", "make sure of your connection");
    }
    update();
  }

  void onInit() async {
    print("init ----------------auth account countroller");
    await gethotels();
    // TODO: implement onInit
    super.onInit();
  }
}
