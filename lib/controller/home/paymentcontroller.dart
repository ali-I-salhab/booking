import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/groups/groupsdata.dart';
import 'package:booking/data/datasource/remote/homepage/payment/paymentdata.dart';
import 'package:booking/data/model/countrymodel.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/paymentmodel.dart';
import 'package:booking/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  TextEditingController? name;
  TextEditingController? marchentuser;
  bool loading = false;
  String? guestgroup;
  HotelModel? hotel;
  String? company;
  List<PaymentModel> payments = [];

  TextEditingController? token;

  TextEditingController? api;
  Statusrequest addpaymentstatusrequest = Statusrequest.none;
  Statusrequest editpaymentstatusrequest = Statusrequest.none;
  Statusrequest fullpagestatusrequest = Statusrequest.none;

  Statusrequest deletepaymentstatusrequest = Statusrequest.none;

  Statusrequest viewpaymentstatusrequest = Statusrequest.none;
  Statusrequest uploadgroupsstatusrequest = Statusrequest.none;

  PaymentData paymentData = PaymentData(Get.find());
  List<GroupModel> alladdedgroups = [];
  GroupsData groupdata = GroupsData(Get.find());
  List handleddata = [];
  void clearcontrollerdata() {
    token!.clear();
    name!.clear();
    api!.clear();
    marchentuser!.clear();
    guestgroup = null;
  }

  handlingApiData(List a) {
    //   List a = [
    //   {"group_name": "midlle east", "country_name": "syria"},
    //   {"group_name": "midssvxlle east", "country_name": "syria"},
    //   {"group_name": "mcvcidlle east", "country_name": "iraq"},
    //   {"group_name": "europ", "country_name": "italya"},
    //   {"group_name": "eurfop", "country_name": "ukrania"},
    //   {"group_name": "europ", "country_name": "russia"}
    // ];
    List groups = [];
    contain(List a, String name) {
      for (int i = 0; i < a.length; i++) {
        if (a[i]['group_name'] == name) {
          return i;
        }
      }
      return -1;
    }

    int j = 0;
    for (int i = 0; i < a.length; i++) {
      if (groups.isEmpty) {
        groups.add({
          "group_id": a[i]['group_id'],
          "group_name": a[i]['group_name'],
          "group_status": a[i]['group_status'],
          "countries": [a[i]['country_name']]
        });
      } else {
        // groups[i]['countries'].add(a[i]['country_name']);
        int kis = contain(groups, a[i]['group_name']);
        if (kis >= 0) {
          // find the contained

          groups[kis]["countries"].add(a[i]['country_name']);
        } else {
          j++;
          groups.add({
            "group_id": a[i]['group_id'],
            "group_name": a[i]['group_name'],
            "group_status": a[i]['group_status'],
            "countries": [a[i]['country_name']]
          });
        }
      }
    }
    // print(groups);
    return groups;
  }

  getallgroups() async {
    alladdedgroups = [];
    uploadgroupsstatusrequest = Statusrequest.loading;
    update();
    var response = await groupdata.groupsview(hotel!.hotelId.toString()!);
    uploadgroupsstatusrequest = handlingdata(response);
    update();

    if (uploadgroupsstatusrequest == Statusrequest.success) {
      print(
          "---------------------------------------------success------getsllgroups----------------");
      if (response["status"] == "success") {
        uploadgroupsstatusrequest = Statusrequest.success;
        update();
        handleddata = handlingApiData(response['data']);
        for (int i = 0; i < handleddata.length; i++) {
          List<String> dd = [];
          for (int j = 0; j < handleddata[i]['countries'].length; j++) {
            dd.add(handleddata[i]['countries'][j]);
          }
          print("------------------------------->$handleddata");
          alladdedgroups.add(GroupModel(dd, handleddata[i]['group_id'],
              name: handleddata[i]['group_name'],
              selected: handleddata[i]['group_status'] == "0" ? false : true));
        }
      } else {
        uploadgroupsstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  delete(String id, [BuildContext? context]) async {
    print(
        "0000000000000003ewrwrweqrewrwr00000000off statement 0000000000000000000000000");
    deletepaymentstatusrequest = Statusrequest.loading;
    update();

    var response = await paymentData.paymentdelete(id);
    print("response =================> $response");
    deletepaymentstatusrequest = handlingdata(response);
    update();

    if (deletepaymentstatusrequest == Statusrequest.success) {
      print("00000000000000000000000off statement 0000000000000000000000000");
      if (response["status"] == "success") {
        Get.snackbar("Successfully", "Delted");

        deletepaymentstatusrequest = Statusrequest.success;
      } else {
        deletepaymentstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  addpayment() async {
    addpaymentstatusrequest = Statusrequest.loading;
    update();

    var response = await paymentData.paymentadd(
        hotel!.hotelId!.toString(),
        name!.text,
        guestgroup!,
        "kashier",
        marchentuser!.text,
        token!.text,
        api!.text);
    print("response =================> $response");
    addpaymentstatusrequest = handlingdata(response);
    update();

    if (addpaymentstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        addpaymentstatusrequest = Statusrequest.success;
        fullpagestatusrequest = Statusrequest.loading;
        update();
        await viewpayment();
        fullpagestatusrequest = Statusrequest.success;
        update();

        Get.back(canPop: false);
        update();
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        addpaymentstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  viewpayment() async {
    viewpaymentstatusrequest = Statusrequest.loading;
    update();

    var response = await paymentData.paymentview(
      hotel!.hotelId!.toString(),
    );
    print("response =================> $response");
    viewpaymentstatusrequest = handlingdata(response);
    update();

    if (viewpaymentstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        payments.addAll(d.map((e) => PaymentModel.fromJson(e)));
      } else {
        // Get.defaultDialog(title: "no uploades photos", middleText: "44".tr);

        viewpaymentstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  @override
  void onInit() async {
    fullpagestatusrequest = Statusrequest.loading;
    update();

    name = TextEditingController();
    marchentuser = TextEditingController();
    token = TextEditingController();
    api = TextEditingController();
    hotel = Get.arguments['hotel'];
    await getallgroups();
    await viewpayment();
    loading = true;
    if (payments.isEmpty) {
      fullpagestatusrequest = Statusrequest.failure;
    } else {
      fullpagestatusrequest = Statusrequest.success;
    }

    update();

    // TODO: implement onInit
    super.onInit();
  }
}
