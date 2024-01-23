import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class RateData {
  Crud crud;
  RateData(this.crud);

  rateview(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.viewrate, {
      "hotelid": hotelid,
    });

    return response.fold((l) => l, (r) => r);
  }

  rateadd(
      String hotelid,
      String roomid,
      String startdate,
      String enddate,
      String group,
      String mealplan,
      String ratevalue,
      String availability) async {
    var response = await crud.postdata(ApiApplinks.addrate, {
      "rates_hotelid": hotelid,
      "rates_startdate": startdate,
      "rates_enddate": enddate,
      "rates_availability": availability,
      "rates_group": group,
      "rates_mealplan": mealplan,
      "rates_roomid": roomid,
      "rates_value": ratevalue,
    });

    return response.fold((l) => l, (r) => r);
  }

  rateedit(String rateid, String availability, String rate, String endate,
      String startdate) async {
    var response = await crud.postdata(ApiApplinks.editrate, {
      "rates_id": rateid,
      "rates_availability": availability,
      "rates_value": rate,
      "rates_startdate": startdate,
      "rates_enddate": endate,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  ratedelete(String rateid) async {
    var response = await crud.postdata(ApiApplinks.deleterate, {
      "rateid": rateid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
