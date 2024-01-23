import 'dart:io';

import 'package:booking/core/constants/route.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/view/home/Homepage.dart';
import 'package:booking/view/home/homescreen.dart';
import 'package:booking/view/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int currenthotel = 0;
  int currentscreen = 0;
  List Screens = [HomeScreen(), Profile()];
  HotelModel? hotel;

  // --------------add room
  gotoaddroomsecondpage() {
    // Get.toNamed(AppRoutes.addroomsecondpage);
  }

  bool showmorestatus = false;
  File? imagefile;
  Map displayed = {};
  Map anotherrooms = {
    4: {"title": "sofa bed", "subtitle": "variable size", "icon": Icons.bed},
    5: {"title": "bunk bed", "subtitle": "variable size", "icon": Icons.bed},
    6: {
      "title": "Extra large bed",
      "subtitle": "variable size",
      "icon": Icons.bed
    },
  };
  Map rooms = {
    0: {
      "title": "single bed",
      "subtitle": "90-130 cm wide ",
      "icon": Icons.bed
    },
    1: {
      "title": "Double bed",
      "subtitle": "131-150 cm wide ",
      "icon": Icons.bed
    },
    2: {
      "title": "large bed",
      "subtitle": "150-180 cm wide ",
      "icon": Icons.bed
    },
    3: {
      "title": "Extra large bed",
      "subtitle": "181-220 cm wide ",
      "icon": Icons.bed
    },
  };

  showmore() {
    showmorestatus = true;
    displayed.clear();
    displayed.addAll(rooms);
    displayed.addAll(anotherrooms);
    update();
  }

  showless() {
    showmorestatus = false;
    displayed.clear();
    displayed.addAll(rooms);
    update();
  }

  gotoRoomPreview() {
    Get.toNamed(AppRoutes.RoomPreview);
  }

  @override
  void onInit() {
    displayed.addAll(rooms);
    hotel = Get.arguments["hotel"];
    print("----------------------------hotel ${hotel!.hotelDesc}");

    // TODO: implement onInit
    super.onInit();
  }
}
