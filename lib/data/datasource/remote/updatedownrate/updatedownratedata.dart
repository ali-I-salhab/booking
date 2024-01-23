import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class UpdatedownrateData {
  Crud crud;
  UpdatedownrateData(this.crud);

// $Updatedownrate_hotelid=filterRequest("hotelid");
// $Updatedownrate_start=filterRequest("Updatedownrate_start");
// $Updatedownrate_end=filterRequest("Updatedownrate_end");
// $Updatedownrate_roomid=filterRequest("Updatedownrate_roomid");

  addUpdatedownrate(String hotelid, String value) async {
    var response = await crud.postdata(ApiApplinks.addUpdatedownrate, {
      "updatedownrate_value": value,
      "updatedownrate_hotelid": hotelid,
    });

    return response.fold((l) => l, (r) => r);
  }

  updateUpdatedownrate(String hotelid, String value) async {
    var response = await crud.postdata(ApiApplinks.editUpdatedownrate, {
      "updatedownrate_value": value,
      "updatedownrate_hotelid": hotelid,
    });

    return response.fold((l) => l, (r) => r);
  }

  viewUpdatedownrate(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.viewUpdatedownrate, {
      "hotelid": hotelid,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteUpdatedownrate(String id) async {
    var response = await crud.postdata(ApiApplinks.deleteUpdatedownrate, {
      "id": id,
    });

    return response.fold((l) => l, (r) => r);
  }
}
