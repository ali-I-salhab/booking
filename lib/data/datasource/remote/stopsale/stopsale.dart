import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class StopsaleData {
  Crud crud;
  StopsaleData(this.crud);

// $stopsale_hotelid=filterRequest("hotelid");
// $stopsale_start=filterRequest("stopsale_start");
// $stopsale_end=filterRequest("stopsale_end");
// $stopsale_roomid=filterRequest("stopsale_roomid");

  addstopsale(String hotelid, String roomid, String start, String end) async {
    var response = await crud.postdata(ApiApplinks.addstopsale, {
      "hotelid": hotelid,
      "stopsale_start": start,
      "stopsale_end": end,
      "stopsale_roomid": roomid
    });

    return response.fold((l) => l, (r) => r);
  }

  updatestopsale(
      String hotelid, String roomid, String start, String end) async {
    var response = await crud.postdata(ApiApplinks.editstopsale, {
      "hotelid": hotelid,
      "stopsale_start": start,
      "stopsale_end": end,
      "stopsale_roomid": roomid
    });

    return response.fold((l) => l, (r) => r);
  }

  viewstopsale(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.viewstopsale, {
      "hotelid": hotelid,
    });

    return response.fold((l) => l, (r) => r);
  }

  deletestopsale(String id) async {
    var response = await crud.postdata(ApiApplinks.deletestopsale, {
      "id": id,
    });

    return response.fold((l) => l, (r) => r);
  }
}
