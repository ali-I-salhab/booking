import 'dart:io';

import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/groups/groupsdata.dart';
import 'package:booking/data/datasource/remote/homepage/mealplans/mealplandata.dart';
import 'package:booking/data/datasource/remote/homepage/rooms/roomsdata.dart';
import 'package:booking/data/model/countrymodel.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/mealplanmodel.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/view/widgets/rooms/roomgroupmealplan.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class RoomController extends GetxController {
  RxDouble scale = 1.0.obs;
  RxBool showmore = false.obs;
  bool isdepartment = false;

  HotelModel? hotel;
  MealplanData mealplandata = MealplanData(Get.find());
  List<RoomModel> alladdedrooms = [];
  String iconscode = "";

  RoomsData roomdata = RoomsData(Get.find());
  Statusrequest uploadroomsstatusrequest = Statusrequest.none;
  Statusrequest addroomsstatusrequest = Statusrequest.none;
  Statusrequest getgroupsstatusrequest = Statusrequest.none;
  Statusrequest uploadroomphotosstatusrequest = Statusrequest.none;
  TextEditingController? room_name;
  TextEditingController? room_desc;
  TextEditingController? room_rate;
  String? roomgroupguest;
  bool uploadcomplete = false;

  TextEditingController? room_availability;
  List<Widget> screens = [];
  List<File> roomphotos = [];
  File? roomlogo;

  List<String> groups = [];
  List<MealPlanModel> mealplans = [];
  filterres(String group) {}
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

  List babyshark = [];
  List filterresult = [];
  bool isfiltered = false;
  RxBool isfilteredobx = false.obs;
  String filteringgroupname = "";
  RxString filternametoobx = "".obs;

  getalloptions(RoomModel room, void Function() fun,
      {String groupname = "all"}) {
    print("fun");
    List<Widget> a = [];
    print(groupname);
    if (groupname == "all") {
      isfiltered = false;
      isfilteredobx.value = false;
      print("all");
      for (int i = 0; i < (groups.length == 0 ? 1 : groups.length); i++) {
        for (int j = 0;
            j < (mealplans.length == 0 ? 1 : mealplans.length);
            j++) {
          a.add(Roomgroupmeal(
              room: room,
              groupname: groups.length == 0 ? "no groups found" : groups[i],
              mealplan: mealplans.length == 0
                  ? "no mealplan found"
                  : mealplans[j].mealplanName!.toString(),
              refresh: fun));
        }
      }
    }
    if (groupname != "all") {
      isfiltered = true;
      isfilteredobx.value = true;
      for (int i = 0; i < groups.length; i++) {
        for (int j = 0; j < mealplans.length; j++) {
          print(groups[i]);
          if (groups[i] == groupname) {
            print("filttttttttttttttering");
            a.add(Roomgroupmeal(
                refresh: fun,
                room: room,
                groupname: groups[i],
                mealplan: mealplans[j].mealplanName!.toString()));
          }
        }
      }
    }
    print("getalloptions $a----------------------------------------------");
    return a;
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

  uploadphotos(String roomid) async {
    uploadroomphotosstatusrequest = Statusrequest.loading;
    List<File> toupload = [];
    toupload.addAll(roomphotos);
    roomphotos.clear();
    update();
    for (int i = 0; i < toupload.length; i++) {
      var response = await roomdata.uploadphotos(roomid, toupload[i]);
      // print("response =================> $response");
      uploadroomphotosstatusrequest = handlingdata(response);

      if (uploadroomphotosstatusrequest == Statusrequest.success) {
        if (response["status"] == "success") {
          // photos.removeAt(i);
          // print(photos);
          // print("here response is $response");
          // statusrequest = Statusrequest.success;
          // Get.snackbar("Success", "Hotel added");
          // Get.toNamed(AppRoutes.homepage);

          update();
        } else {
          // Get.defaultDialog(title: "42".tr, middleText: "44".tr);

          uploadroomphotosstatusrequest = Statusrequest.failure;
          update();
        }
      }
      print("---------------------------upload photo $i");
    }
    // uploadcomplete = true;
    roomphotos = [];
    update();
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

        uploadroomsstatusrequest = Statusrequest.success;
        update();
      } else {
        uploadroomsstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  getroomimages(String roomid) async {
    var response = await roomdata.getroomimages(roomid);

    if (uploadroomsstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        print(d[0]['photo_name']);
      }
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
        print("0000000000000000000000000000000888");
        print(groups);
      } else {
        getgroupsstatusrequest = Statusrequest.failure;
        update();
      }
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

  addroom() async {
    print("adding new room ----------------------------1--------<p_q>");
    uploadcomplete = true;
    update();
    addroomsstatusrequest = Statusrequest.loading;
    update();
    for (int i = 0; i < hoteliconssvg.length; i++) {
      print("adding new room ---------------------$i---------------<p_q>");

      if (hoteliconssvg[i]['selected']) {
        iconscode += '1';
      } else {
        iconscode += '0';
      }
    }

    var response = await roomdata.roomsadd(
        room_name!.text,
        hotel!.hotelId.toString()!,
        room_desc!.text,
        room_desc!.text,
        rooms[0]["count"].toString(),
        rooms[1]["count"].toString(),
        rooms[2]["count"].toString(),
        rooms[3]["count"].toString(),
        guests[0]['count'].toString(),
        guests[1]['count'].toString(),
        guests[2]['count'].toString(),
        guests[3]['count'].toString(),
        mailplans[0]["value"] == true ? "1" : "0",
        mailplans[1]["value"] == true ? "1" : "0",
        mailplans[2]["value"] == true ? "1" : "0",
        mailplans[3]["value"] == true ? "1" : "0",
        room_rate!.text,
        room_availability!.text,
        iconscode,
        roomlogo!);
    addroomsstatusrequest = handlingdata(response);
    update();
    print("adding new room ------------------------------------<p_q>");

    if (addroomsstatusrequest == Statusrequest.success) {
      print("adding new room ---------------------------success---------<p_q>");

      if (response["status"] == "success") {
        await uploadphotos(response['data']);
        uploadcomplete = false;

        Get.back();
        await getallrooms();
      }
    } else {
      addroomsstatusrequest = Statusrequest.failure;
      update();
    }
  }

  deleteroom(String roomid) async {
    addroomsstatusrequest = Statusrequest.loading;
    update();
    var response = await roomdata.roomsdelete(roomid);
    addroomsstatusrequest = handlingdata(response);

    if (addroomsstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        addroomsstatusrequest = Statusrequest.success;
        update();

        await getallrooms();
      }
    } else {
      addroomsstatusrequest = Statusrequest.failure;
      update();
    }
  }

  void cleardata() {
    print("Clearing room controller data function");
    iconscode = "";
    if (room_desc != null &&
        room_name != null &&
        room_rate != null &&
        room_availability != null) {
      room_name!.clear();
      room_desc!.clear();
      room_rate!.clear();

      room_availability!.clear();
    }
    roomphotos = [];
    roomlogo = null;
    hoteliconssvg = [
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
  }

  @override
  void onInit() async {
    hotel = Get.arguments['hotel'];

    await getgroups();
    await getmealplans();
    // screens = await getalloptions();
    await getallrooms();
    update();
    print("---------------------------------");
    print(screens);

    room_name = TextEditingController();
    room_desc = TextEditingController();
    room_rate = TextEditingController();
    room_availability = TextEditingController();

    print(hotel);
    // TODO: implement onInit
    super.onInit();
  }
}
