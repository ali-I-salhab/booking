import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:flutter/material.dart';

import '../../../../core/class/crud.dart';

class AuthData {
  Crud crud;
  AuthData(this.crud);

  hotelview(String userid) async {
    var response = await crud.postdata(ApiApplinks.hoteldetailsview, {
      "userid": userid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  deletehote(String hotelid, String oldimagename) async {
    var response = await crud.postdata(ApiApplinks.deletehotel,
        {"hotelid": hotelid, "oldimagename": oldimagename});

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
//         addresses.addAll(d.map((e) => AddressModel.fromJson(e)));