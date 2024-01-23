import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class UsersData {
  Crud crud;
  UsersData(this.crud);

  usersview(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.usersview, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

// $user_hotelid=filterRequest("user_hotelid");
// $user_name=filterRequest("user_name");
// $user_permitions=filterRequest("user_permitions");
// $user_pohone=filterRequest("user_pohone");
// $user_profileimage=filterRequest("user_profileimage");
// $user_email=filterRequest("user_email");
// $user_password=filterRequest("user_password");
  usersadd(String hotelid, String name, String permitions, String email,
      String phone, String password, String userdesc, File image) async {
    var response = await crud.addRequestWithImageOne(
        ApiApplinks.usersadd,
        {
          "user_hotelid": hotelid,
          "user_name": name,
          "user_permitions": permitions,
          "user_pohone": phone,
          "user_desc": userdesc,
          // "user_profileimage": profileimage,
          "user_email": email,
          "user_password": password,
        },
        image);

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  usersedit(String hotelid, String name, String permitions, String email,
      String phone, String password, String profileimage) async {
    var response = await crud.postdata(ApiApplinks.usersedit, {
      "user_hotelid": hotelid,
      "user_name": name,
      "user_permitions": permitions,
      "user_pohone": phone,
      "user_profileimage": profileimage,
      "user_email": email,
      "user_password": password,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  usersdelete(String id) async {
    var response = await crud.postdata(ApiApplinks.usersdelete, {
      "id": id,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
