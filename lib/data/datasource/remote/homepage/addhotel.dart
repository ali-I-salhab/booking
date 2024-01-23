import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:flutter/material.dart';

import '../../../../core/class/crud.dart';

class AddHotelData {
  Crud crud;
  AddHotelData(this.crud);

  addhoteldetails(
      String hotelicons,
      String name,
      String namear,
      String description,
      String descriptionar,
      String logo,
      String long,
      String lat,
      String rating,
      String doc,
      String location,
      String userid,
      File? image) async {
    var response = await crud.addRequestWithImageOne(
        ApiApplinks.addhoteldetails,
        {
          "hotelname": name,
          "hoteldesc": description,
          "hoteldescar": location,
          "hotelnamear": namear,
          "hotellogo": logo,
          "hotellong": long,
          "hotellat": lat,
          "hoteldoc": doc,
          "hotelrating": rating,
          "hotellocation": location,
          "hoteluserid": userid,
          "hotelicons": hotelicons,
        },
        image);

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  hotelview(String userid) async {
    var response = await crud.postdata(ApiApplinks.login, {
      "userid": userid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  updatehoteldetails(
    String id,
    String iconcode,
    String name,
    String namear,
    String description,
    String descriptionar,
    String logo,
    String long,
    String lat,
    String rating,
    String doc,
    String location,
    String userid,
    File? image,
    String oldimagename,
  ) async {
    var response = await crud.addRequestWithImageOne(
        ApiApplinks.hoteldetailsedit,
        {
          "id": id,
          "iconcode": iconcode,
          "hotelname": name,
          "hoteldesc": description,
          "hoteldescar": location,
          "hotelnamear": namear,
          "hotellogo": logo,
          "hotellong": long,
          "hotellat": lat,
          "hoteldoc": doc,
          "hotelrating": rating,
          "hotellocation": location,
          "hoteluserid": userid,
          "oldimagename": oldimagename
        },
        image);

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
