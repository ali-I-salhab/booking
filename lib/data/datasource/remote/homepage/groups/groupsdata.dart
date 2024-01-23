import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/crud.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';

class GroupsData {
  Crud crud;
  GroupsData(this.crud);

  groupsview(String hotelid) async {
    var response = await crud.postdata(ApiApplinks.groupview, {
      "hotelid": hotelid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  updategroupstatu(String groupid, String status) async {
    var response = await crud.postdata(
        ApiApplinks.updategroupstatus, {"id": groupid, "status": status});

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

// st('groupname');
// $hotelid=filterRequest('hotelid');
// $countries=filterRequest('countries');
// $status=filterRequest('status');
  groupsadd(String name, String hotelid, String status,
      List<String> countries) async {
    String a = '';

    a = countries.join(',');

    var response = await crud.postdata(ApiApplinks.groupadd, {
      "groupname": name,
      "hotelid": hotelid,
      "status": status,
      "countries": a
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
// $groupid=filterRequest('groupid');
// $groupname=filterRequest('groupname');

// $countries=filterRequest('countries');
  groupsedit(
    String groupid,
    String groupname,
    List<String> countries,
  ) async {
    String a = '';

    a = countries.join(',');
    var response = await crud.postdata(ApiApplinks.groupedit, {
      "groupid": groupid,
      "groupname": groupname,
      "countries": a,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }

  groupsdelete(String groupid) async {
    var response = await crud.postdata(ApiApplinks.groupdelete, {
      "groupid": groupid,
    });

    // print(response);
    return response.fold((l) => l, (r) => r);
  }
}
