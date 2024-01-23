import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class PaymentData {
  Crud crud;
  PaymentData(this.crud);

  paymentview(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.viewpayment, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  paymentadd(String hotelid, String name, String group, String company,
      String marchentuser, String token, String api) async {
    var response = await crud.postdata(
      ApiApplinks.addpayment,
      {
        "payment_hotelid": hotelid,
        "payment_name": name,
        "payment_guestgroup": group,
        "payment_company": company,
        "payment_marchentuser": marchentuser,
        // "user_profileimage": profileimage,
        "payment_token": token,
        "payment_api": api,
      },
    );

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  paymentedit(String hotelid, String name, String group, String company,
      String marchentuser, String token, String api) async {
    var response = await crud.postdata(ApiApplinks.editpayment, {
      "payment_hotelid": hotelid,
      "payment_name": name,
      "payment_guestgroup": group,
      "payment_company": company,
      "payment_marchentuser": marchentuser,
      // "user_profileimage": profileimage,
      "payment_token": token,
      "payment_api": api,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  paymentdelete(String id) async {
    var response = await crud.postdata(ApiApplinks.deletepayment, {
      "id": id,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
