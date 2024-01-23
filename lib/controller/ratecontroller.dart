import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/mealplans/mealplandata.dart';
import 'package:booking/data/datasource/remote/homepage/perioddata.dart';
import 'package:booking/data/datasource/remote/homepage/rates/ratedata.dart';
import 'package:booking/data/datasource/remote/homepage/rooms/roomsdata.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/mealplanmodel.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/view/home/homecardscreens/rates.dart';
import 'package:booking/view/widgets/rooms/roomgroupmealplan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class Ratecontroller extends GetxController {
  RxDouble scale = 1.0.obs;
  RxBool showmore = false.obs;
  bool isdepartment = false;

  HotelModel? hotel;
  MealplanData mealplandata = MealplanData(Get.find());
  RateData rateData = RateData(Get.find());

  List<RoomModel> alladdedrooms = [];
  String iconscode = "";

  RoomsData roomdata = RoomsData(Get.find());
  Statusrequest uploadroomsstatusrequest = Statusrequest.none;
  Statusrequest addroomsstatusrequest = Statusrequest.none;
  Statusrequest getgroupsstatusrequest = Statusrequest.none;
  Statusrequest uploadroomphotosstatusrequest = Statusrequest.none;
  Statusrequest addratestatusrequest = Statusrequest.none;
  Statusrequest viewratestatusrequest = Statusrequest.none;
  Statusrequest allpagestatus = Statusrequest.none;
  Statusrequest viewperiodstatusrequest = Statusrequest.none;

  TextEditingController? rate;
  TextEditingController? availability;
  String? roomgroupguest;
  bool uploadcomplete = false;
  File? roomlogo;
  RxString? startdate = "".obs;
  RxString? enddate = "".obs;
  RxBool isfiltered = false.obs;
  TextEditingController? room_availability;
  List<Widget> screens = [];
  List<File> roomphotos = [];
  List a = [];
  List periods = [];
  PeriodsData periodsData = PeriodsData(Get.find());
  RxString appliedfilter = "".obs;
  List<String> groups = [];
  List<MealPlanModel> mealplans = [];
  List<Widget> filterresult = [];
  List<Widget> alloptions = [];
  getalloptions(RoomModel room) {
    print("get optiiions");
    List<Widget> a = [];

    for (int i = 0; i < groups.length; i++) {
      for (int j = 0; j < mealplans.length; j++) {
        for (int k = 0; k < periods.length; k++) {
          a.add(Rategroupmeal(
            room: room,
            groupname: groups[i],
            mealplan: mealplans[j].mealplanName!.toString(),
            periodstart: periods[k]['period_start'],
            periodend: periods[k]['period_end'],
          ));
        }
      }
    }
    print(a.length);
    alloptions = a;
    return a;
  }

  filter(RoomModel room, {String group = "", String meal = ""}) {
    List<Widget> a = [];
    for (int i = 0; i < groups.length; i++) {
      if (group != "" && groups[i] != group) continue;
      for (int j = 0; j < mealplans.length; j++) {
        if (meal != "" && mealplans[j].mealplanName != meal) continue;

        for (int k = 0; k < periods.length; k++) {
          if (groups[i] == group || mealplans[j].mealplanName == meal) {
            print(groups[i]);
            print(mealplans[j].mealplanName);
            a.add(Rategroupmeal(
              room: room,
              groupname: groups[i],
              mealplan: mealplans[j].mealplanName!.toString(),
              periodstart: periods[k]['period_start'],
              periodend: periods[k]['period_end'],
            ));
          }
        }
      }
    }
    filterresult = a;
  }

  List rooms = [
    {"room_type": "Extra Large bed", "count": 0},
    {"room_type": "Sofa bed", "count": 0},
    {"room_type": "bunk bed", "count": 0},
    {"room_type": "single bed", "count": 0}
  ];
  // =================================
  List guests = [
    {"guest_type": "Adult", "count": 0, "icon": Ionicons.person},
    {
      "guest_type": "Chaildren Under 6",
      "count": 0,
      "icon": Icons.child_friendly
    },
    {"guest_type": "Children Under 12", "count": 0, "icon": Icons.boy},
    {"guest_type": "Infant", "count": 0, "icon": Icons.person}
  ];

  // --------------------------------
  List mailplans = [
    {"type": "bed only", "value": false},
    {"type": "Half Board", "value": false},
    {"type": "Bed & Break Fast", "value": false},
    {"type": "All Inclusive", "value": false}
  ];

  List hoteliconssvg = [
    {"icon_name": "Ac", "icon": ImageAssets.ac, "selected": false},
    {"icon_name": "ATM", "icon": ImageAssets.ATM, "selected": false},
    {"icon_name": "Bar", "icon": ImageAssets.Bar, "selected": false},
    {
      "icon_name": "Fitness centre",
      "icon": ImageAssets.Fitnesscentre,
      "selected": false
    },
    {
      "icon_name": "Beachfront",
      "icon": ImageAssets.Beachfront,
      "selected": false
    },
    {"icon_name": "Parking", "icon": ImageAssets.Parking, "selected": false},
    {
      "icon_name": "Private beach area",
      "icon": ImageAssets.Privatebeacharea,
      "selected": false
    },
    {
      "icon_name": "Reciption",
      "icon": ImageAssets.Reciption,
      "selected": false
    },
    {
      "icon_name": "Restaurants",
      "icon": ImageAssets.Restaurants,
      "selected": false
    },
    {
      "icon_name": "Spaand wellness centre",
      "icon": ImageAssets.Spaandwellnesscentre,
      "selected": false
    },
    {
      "icon_name": "Water Park",
      "icon": ImageAssets.WaterPark,
      "selected": false
    },
    {"icon_name": "Wifi", "icon": ImageAssets.Wifi, "selected": false},
  ];
  getsvgfromiconcode(String code) {
    print(code);
    List<String> a = [];

    for (int i = 0; i < code.length; i++) {
      if (code[i] == '1') {
        a.add(hoteliconssvg[i]["icon"]);
      }
    }
    print(a);

    return a;
  }

  viewperiod() async {
    viewperiodstatusrequest = Statusrequest.loading;

    update();
    var response = await periodsData.viewperiod(hotel!.hotelId!);
    viewperiodstatusrequest = handlingdata(response);

    update();

    if (viewperiodstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        periods = response['data'];
        print(periods);
      } else {
        viewperiodstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  getallrooms() async {
    alladdedrooms = [];
    uploadroomsstatusrequest = Statusrequest.loading;
    update();
    var response = await roomdata.roomsview(hotel!.hotelId.toString()!);
    uploadroomsstatusrequest = handlingdata(response);

    if (uploadroomsstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print("rooms ------------------->");
        print(response['data']);

        List d = response['data'];
        alladdedrooms.addAll(d.map((e) => RoomModel.fromJson(e)));
      }

      uploadroomsstatusrequest = Statusrequest.success;
      update();
    } else {
      uploadroomsstatusrequest = Statusrequest.failure;
      update();
    }
  }

  getgroups() async {
    getgroupsstatusrequest = Statusrequest.loading;
    update();
    var response = await roomdata.getgroups(hotel!.hotelId.toString()!);
    getgroupsstatusrequest = handlingdata(response);

    if (getgroupsstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print(response['data']);
        for (int i = 0; i < response['data'].length; i++) {
          groups.add(response['data'][i]['group_name']);
        }
        print(groups);
      }

      getgroupsstatusrequest = Statusrequest.success;
      update();
    } else {
      getgroupsstatusrequest = Statusrequest.failure;
      update();
    }
  }

  getmealplans() async {
    getgroupsstatusrequest = Statusrequest.loading;
    update();
    var response = await mealplandata.mealplanview(hotel!.hotelId.toString()!);
    getgroupsstatusrequest = handlingdata(response);

    if (getgroupsstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print(response['data']);

        List d = response['data'];
        mealplans.addAll(d.map((e) => MealPlanModel.fromJson(e)));

        print("object");
        print(mealplans);
      }

      getgroupsstatusrequest = Statusrequest.success;
      update();
    } else {
      getgroupsstatusrequest = Statusrequest.failure;
      update();
    }
  }

  addrate(String roomid, String group, String mealplan) async {
    addratestatusrequest = Statusrequest.loading;
    update();
    var response = await rateData.rateadd(
        hotel!.hotelId.toString()!,
        roomid,
        startdate!.value.toString(),
        enddate!.value.toString(),
        group,
        mealplan,
        rate!.text.toString(),
        availability!.text.toString());
    addratestatusrequest = handlingdata(response);

    if (addratestatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        Get.back(canPop: false);
        onInit();
        print("response for add rate -----------------> $response");
      }

      addratestatusrequest = Statusrequest.success;
      update();
    } else {
      addratestatusrequest = Statusrequest.failure;
      update();
    }
  }

  viewrates() async {
    viewratestatusrequest = Statusrequest.loading;
    update();
    var response = await rateData.rateview(
      hotel!.hotelId.toString()!,
    );
    viewratestatusrequest = handlingdata(response);

    if (viewratestatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        a = response['data'];
        print("response for add rate -----------------> $response");
        viewratestatusrequest = Statusrequest.success;
        update();
      }

      viewratestatusrequest = Statusrequest.success;
      update();
    } else {
      viewratestatusrequest = Statusrequest.failure;
      update();
    }
  }

  deleterates(String rateid) async {
    viewratestatusrequest = Statusrequest.loading;
    update();
    var response = await rateData.ratedelete(rateid);
    viewratestatusrequest = handlingdata(response);

    if (viewratestatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        Get.back(canPop: false);
        onInit();
      }

      viewratestatusrequest = Statusrequest.success;
      update();
    } else {
      viewratestatusrequest = Statusrequest.failure;
      update();
    }
  }

  updaterateoravailability(String enddate, String startdate, String rateid,
      String availability, String rate) async {
    print(
        "------------------------enddate $enddate ----------- last date ---------------$startdate");
    viewratestatusrequest = Statusrequest.loading;
    update();
    var response =
        await rateData.rateedit(rateid, availability, rate, enddate, startdate);
    viewratestatusrequest = handlingdata(response);

    if (viewratestatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        Get.back(canPop: false);
        onInit();
      }

      viewratestatusrequest = Statusrequest.success;
      update();
    } else {
      viewratestatusrequest = Statusrequest.failure;
      update();
    }
  }

  handlingfun(String roomid, String mealplan, String group) {
    List neededdata = [];
    int j = 0;
    // print("-------------------------------handling fun");
    // print(a);
    // print(mealplan);
    // print(group);
    // print(roomid);
    for (int i = 0; i < a.length; i++) {
      print(a[i]['rates_group']);
      if (a[i]["rates_roomid"] == roomid &&
          a[i]['rates_group'] == group &&
          a[i]["rates_mealplan"] == mealplan) {
        print("true");
        neededdata.add({
          "id": a[i]["rates_id"],
          "from": a[i]["rates_startdate"],
          "to": a[i]["rates_enddate"],
          "rate": a[i]["rates_value"],
          "availability": a[i]["rates_availability"]
        });
      }
    }
    print("needed data is ------------------------->");
    print(neededdata);
    // update();
    return neededdata;
  }

  List<Widget> allrooms = [];
  fun() {
    for (int i = 0; i < alladdedrooms.length; i++) {
      allrooms.addAll(getalloptions(alladdedrooms[i]));
    }
    allpagestatus = Statusrequest.success;
  }

  @override
  void onInit() async {
    rate = TextEditingController();
    availability = TextEditingController();
    hotel = Get.arguments['hotel'];
    allpagestatus = Statusrequest.loading;
    await getgroups();
    await getmealplans();
    await viewperiod();
    await getallrooms();
    await viewrates();
    fun();

    allpagestatus = Statusrequest.success;
    update();

    // TODO: implement onInit
    super.onInit();
  }
}
