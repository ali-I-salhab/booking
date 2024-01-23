import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:flutter/material.dart';

import '../../../../core/class/crud.dart';

class PhotosData {
  Crud crud;
  PhotosData(this.crud);

  uploadphotos(String hotelid, File image) async {
    var response = await crud.addRequestWithImageOne(
        ApiApplinks.photosupload, {"hotelid": hotelid}, image);

    return response.fold((l) => l, (r) => r);
  }

  viewphotos(String hotelid) async {
    var response =
        await crud.postdata(ApiApplinks.photosview, {"hotelid": hotelid});

    return response.fold((l) => l, (r) => r);
  }

  deletephoto(String imageid, String imagename) async {
    var response = await crud.postdata(
        ApiApplinks.photosdelete, {"id": imageid, "imagename": imagename});

    return response.fold((l) => l, (r) => r);
  }

  editphoto(String imageid, File image, String oldimagename) async {
    var response = await crud.addRequestWithImageOne(ApiApplinks.photosedit,
        {"id": imageid, "oldimagename": oldimagename}, image);

    return response.fold((l) => l, (r) => r);
  }
}
