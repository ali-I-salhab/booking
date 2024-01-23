import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/functions/checkinternetconnection.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/groups/groupsdata.dart';
import 'package:booking/data/model/countrymodel.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  TextEditingController? groupname;
  RxBool enabled = true.obs;
  HotelModel? hotel;
  List handleddata = [];
  List<String> addGroupSelectedCountrie = [];
  List<GroupModel> alladdedgroups = [];
  GroupsData groupdata = GroupsData(Get.find());
  Statusrequest uploadgroupsstatusrequest = Statusrequest.none;
  Statusrequest addgroupsstatusrequest = Statusrequest.none;
  Statusrequest deletegroupsstatusrequest = Statusrequest.none;
  Statusrequest updategroupsstatusrequest = Statusrequest.none;

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

  addgroup() async {
    addgroupsstatusrequest = Statusrequest.loading;

    update();
    var response = await groupdata.groupsadd(groupname!.text,
        hotel!.hotelId.toString()!, '0', addGroupSelectedCountrie);
    addgroupsstatusrequest = handlingdata(response);

    if (addgroupsstatusrequest == Statusrequest.success) {
      print(
          "---------------------------------------------success----------------------");
      if (response["status"] == "success") {
        addgroupsstatusrequest = Statusrequest.success;
        update();
      } else {
        addgroupsstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  updategroup(String groupid) async {
    updategroupsstatusrequest = Statusrequest.loading;

    update();
    var response = await groupdata.groupsedit(
        groupid, groupname!.text, addGroupSelectedCountrie);
    updategroupsstatusrequest = handlingdata(response);

    if (updategroupsstatusrequest == Statusrequest.success) {
      print(
          "---------------------------------------------success----------------------");
      if (response["status"] == "success") {
        updategroupsstatusrequest = Statusrequest.success;
        update();
      } else {
        updategroupsstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  updategroupstatus(String groupid, bool status) async {
    print("delete group fun");
    deletegroupsstatusrequest = Statusrequest.loading;

    update();
    var response =
        await groupdata.updategroupstatu(groupid, status == true ? "1" : "0");
    addgroupsstatusrequest = handlingdata(response);

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

  deletegroup(String groupid) async {
    print("delete group fun");
    deletegroupsstatusrequest = Statusrequest.loading;

    update();
    var response = await groupdata.groupsdelete(
      groupid,
    );
    addgroupsstatusrequest = handlingdata(response);

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

  @override
  void dispose() {
    groupname!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // creategroup() {
  //   alladdedgroups.add(GroupModel(addGroupSelectedCountrie,
  //       name: groupname!.text.toString(), selected: false));
  //   Get.back(canPop: false);
  //   update();
  // }

  onsave() {
    // print("object");
    // guestgroup.clear();

    // groups.add({"name": groupname!.text, "country": country, "list": []});

    // Get.back(canPop: false);
  }
  @override
  void onInit() async {
    hotel = Get.arguments['hotel'];
    await getallgroups();

    groupname = TextEditingController();
    // for (int i = 0; i < handleddata.length; i++) {
    //   List<String> dd = [];
    //   for (int j = 0; j < handleddata[i]['countries'].length; j++) {
    //     dd.add(handleddata[i]['countries'][j]);
    // }
    //   alladdedgroups.add(GroupModel(dd, handleddata[i]['group_id'],
    //       name: handleddata[i]['group_name'], selected: false));
    // }

    // TODO: implement onInit
    super.onInit();
  }
}
