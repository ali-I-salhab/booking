import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

// mealplans/updatemealplanstatus.php
class MealplanData {
  Crud crud;
  MealplanData(this.crud);

  mealplanview(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.mealplansview, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  updatemealplanstatu(String groupid, String status) async {
    var response = await crud.postdata(
        ApiApplinks.updatemealplanstatus, {"id": groupid, "status": status});

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  mealplanedit(String id, String name, String desc) async {
    var response = await crud.postdata(ApiApplinks.mealplansedit, {
      "id": id,
      "name": name,
      "desc": desc,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  mealplanadd(String hotelid, String name, String desc) async {
    var response = await crud.postdata(ApiApplinks.mealplansadd, {
      "hotelid": hotelid,
      "name": name,
      "desc": desc,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  mealplandelete(String id) async {
    var response = await crud.postdata(ApiApplinks.mealplansdelete, {
      "id": id,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
