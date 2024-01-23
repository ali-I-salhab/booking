import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class RoomsData {
  Crud crud;
  RoomsData(this.crud);

  uploadphotos(String roomid, File image) async {
    var response = await crud.addRequestWithImageOne(
        ApiApplinks.uploadroomphotos, {"roomid": roomid}, image);

    return response.fold((l) => l, (r) => r);
  }

  getroomimages(String roomid) async {
    var response =
        await crud.postdata(ApiApplinks.getroomimages, {"roomid": roomid});

    return response.fold((l) => l, (r) => r);
  }

  roomsview(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.roomview, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  getgroups(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.getgroupsfromrooms, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

/*$roomname=filterRequest('room_name');
$room_hotelid=filterRequest('room_hotelid');
$room_desc_ar=filterRequest('room_desc_ar');
$room_desc_en=filterRequest('room_desc_en');
$room_extralargbed=filterRequest('room_extralargbed');
$room_sofabed=filterRequest('room_sofabed');
$room_bunkbed=filterRequest('room_bunkbed');
$room_singlebed=filterRequest('room_singlebed');
$room_adult=filterRequest('room_adult');
$room_childrenundersix=filterRequest('room_childrenundersix');
$room_childrenundertwelf=filterRequest('room_childrenundertwelf');
$room_infant=filterRequest('room_infant');
$room_bedonly=filterRequest('room_bedonly');
$room_halfboard=filterRequest('room_halfboard');
$room_bedbrekfast=filterRequest('room_bedbrekfast');
$room_allinclusive=filterRequest('room_allinclusive');
$room_groupguest=filterRequest('room_groupguest');
$room_rate=filterRequest('room_rate');
$room_availbility=filterRequest('room_availbility'); */
  roomsadd(
      String room_name,
      String room_hotelid,
      String room_desc_ar,
      String room_desc_en,
      String room_extralargbed,
      String room_sofabed,
      String room_bunkbed,
      String room_singlebed,
      String room_adult,
      String room_childrenundersix,
      String room_childrenundertwelf,
      String room_infant,
      String room_bedonly,
      String room_halfboard,
      String room_bedbrekfast,
      String room_allinclusive,
      String room_rate,
      String room_availbility,
      String iconcode,
      File logo) async {
    var response = await crud.addRequestWithImageOne(
        ApiApplinks.roomadd,
        {
          "room_name": room_name,
          "room_hotelid": room_hotelid,
          "room_desc_ar": room_desc_ar,
          "room_desc_en": room_desc_en,
          "room_extralargbed": room_extralargbed,
          "room_sofabed": room_sofabed,
          "room_bunkbed": room_bunkbed,
          "room_singlebed": room_singlebed,
          "room_adult": room_adult,
          "room_childrenundersix": room_childrenundersix,
          "room_childrenundertwelf": room_childrenundertwelf,
          "room_infant": room_infant,
          "room_bedonly": room_bedonly,
          "room_halfboard": room_halfboard,
          "room_bedbrekfast": room_bedbrekfast,
          "room_allinclusive": room_allinclusive,
          "room_rate": room_rate,
          "room_availbility": room_availbility,
          "room_icons": iconcode
        },
        logo);

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  roomsedit(String roomid) async {
    var response = await crud.postdata(ApiApplinks.roomedit, {
      "roomid": roomid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  roomsdelete(String roomid) async {
    var response = await crud.postdata(ApiApplinks.roomdelete, {
      "roomid": roomid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
