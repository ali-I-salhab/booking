import 'dart:io';

import 'package:booking/Apiapplink.dart';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/photsdata.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/photomodel.dart';
import 'package:get/get.dart';

class PhotosController extends GetxController {
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest uploadstatusrequest = Statusrequest.none;
  Statusrequest updatephotostatusrequest = Statusrequest.none;
  PhotosData photodata = PhotosData(Get.find());
  List<File> photos = [];
  File? croppedimage;
  List<PhotoModel> photosview = [];
  HotelModel? hotel;

  uploadphotos() async {
    uploadstatusrequest = Statusrequest.loading;
    List<File> toupload = [];
    toupload.addAll(photos);
    photos.clear();
    update();
    for (int i = 0; i < toupload.length; i++) {
      var response =
          await photodata.uploadphotos(hotel!.hotelId.toString(), toupload[i]);
      // print("response =================> $response");
      uploadstatusrequest = handlingdata(response);

      if (uploadstatusrequest == Statusrequest.success) {
        if (response["status"] == "success") {
        } else {
          uploadstatusrequest = Statusrequest.failure;
          update();
        }
      }
      print("---------------------------upload photo $i");
    }
    uploadstatusrequest = Statusrequest.success;

    photos = [];
    update();
  }

  showuploadedphotos() async {
    statusrequest = Statusrequest.loading;
    update();
    photosview.clear();

    var response = await photodata.viewphotos(hotel!.hotelId.toString());

    statusrequest = handlingdata(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        photosview.addAll(d.map((e) => PhotoModel.fromJson(e)));

        statusrequest = Statusrequest.success;
        update();
      } else {
        statusrequest = Statusrequest.failure;
        update();
      }
    }
  }

// -------------------------------------------------
  deletephoto(String imageid, String imagename) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await photodata.deletephoto(imageid, imagename);
    statusrequest = handlingdata(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        // print("here response is $response");
        // statusrequest = Statusrequest.success;
        // Get.snackbar("Success", "Hotel added");
        // Get.toNamed(AppRoutes.homepage);
        statusrequest = Statusrequest.success;
        await showuploadedphotos();

        update();
      } else {
        Get.defaultDialog(title: "42".tr, middleText: "44".tr);

        statusrequest = Statusrequest.failure;
        update();
      }
    }

    update();
  }

  updatephoto(File image, String id, String oldname) async {
    updatephotostatusrequest = Statusrequest.loading;
    update();

    var response = await photodata.editphoto(id, image, oldname);
    updatephotostatusrequest = handlingdata(response);

    if (updatephotostatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        await showuploadedphotos();

        update();
      } else {
        updatephotostatusrequest = Statusrequest.failure;
        update();
      }
    }

    update();
  }

  @override
  void onInit() async {
    hotel = Get.arguments == null ? null : Get.arguments['hotel'];

    await showuploadedphotos();
    update();

    super.onInit();
  }
}
