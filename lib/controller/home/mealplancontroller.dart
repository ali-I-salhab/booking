import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/mealplans/mealplandata.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/mealplanmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealplanControlle extends GetxController {
  RxBool enable = true.obs;
  List<MealPlanModel> mealplans = [];
  HotelModel? hotel;
  RxBool enabled = true.obs;
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest addstatusrequest = Statusrequest.none;
  Statusrequest deletegroupsstatusrequest = Statusrequest.none;
  Statusrequest updatestatusrequest = Statusrequest.none;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController? mealplanname;
  TextEditingController? mealplandesc;
  MealplanData mealplanData = MealplanData(Get.find());

  updatemealplanstatus(String mealplanid, bool status) async {
    print("delete group fun");
    deletegroupsstatusrequest = Statusrequest.loading;

    update();
    var response = await mealplanData.updatemealplanstatu(
        mealplanid, status == true ? "1" : "0");
    deletegroupsstatusrequest = handlingdata(response);

    if (deletegroupsstatusrequest == Statusrequest.success) {
      print(
          "---------------------------------------------success----------------------");
      if (response["status"] == "success") {
        deletegroupsstatusrequest = Statusrequest.success;
        update();
      } else {
        deletegroupsstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  // List mealplans = [
  //   {"name": "breakfast", "status": false},
  //   {"name": "breakfast", "status": false},
  //   {"name": "breakfast", "status": true},
  //   {"name": "breakfast", "status": false},
  // ];
  addmealplan() async {
    addstatusrequest = Statusrequest.loading;
    update();

    var response = await mealplanData.mealplanadd(
        hotel!.hotelId.toString(), mealplanname!.text, mealplandesc!.text);
    print("response =================> $response");
    addstatusrequest = handlingdata(response);
    update();

    if (addstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        addstatusrequest = Statusrequest.success;
        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        addstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  updatemealplan(String id) async {
    print(" update 1");
    updatestatusrequest = Statusrequest.loading;
    update();

    var response = await mealplanData.mealplanedit(
        id, mealplanname!.text, mealplandesc!.text);
    print("response =================> $response");
    updatestatusrequest = handlingdata(response);
    update();

    if (updatestatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        await viewmealplans();
        updatestatusrequest = Statusrequest.success;

        Get.back(canPop: false);
        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);
        Get.back();

        // updatestatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  viewmealplans() async {
    mealplans.clear();
    statusrequest = Statusrequest.loading;
    update();

    var response = await mealplanData.mealplanview(hotel!.hotelId.toString());
    print("response =================> $response");
    statusrequest = handlingdata(response);
    update();
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        mealplans.addAll(d.map((e) => MealPlanModel.fromJson(e)));
        print("------------------------>");
        print(mealplans);
        statusrequest = Statusrequest.success;
        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        statusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  deletemealplan(String id) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await mealplanData.mealplandelete(id);
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
    mealplanname = TextEditingController();
    mealplandesc = TextEditingController();
    await viewmealplans();

    // TODO: implement onInit
    super.onInit();
  }
}
