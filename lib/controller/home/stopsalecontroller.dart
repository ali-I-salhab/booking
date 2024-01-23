import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/rooms/roomsdata.dart';
import 'package:booking/data/datasource/remote/stopsale/stopsale.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:booking/data/model/stopsalemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StopSaleController extends GetxController {
  String? startdate;
  String? enddate;
  String? roomid;
  String? roomname;
  Statusrequest uploadroomsstatusrequest = Statusrequest.none;
  Statusrequest addstopsalesstatusrequest = Statusrequest.none;
  Statusrequest viewstopsalesstatusrequest = Statusrequest.none;

  RoomsData roomdata = RoomsData(Get.find());
  StopsaleData stopsaledata = StopsaleData(Get.find());

  List<RoomModel> alladdedrooms = [];
  List<StopsaleModel> stopsale = [];
  HotelModel? hotel;

  getallrooms() async {
    print("---------------------------get all rooms");
    alladdedrooms = [];
    uploadroomsstatusrequest = Statusrequest.loading;
    update();
    var response = await roomdata.roomsview(hotel!.hotelId.toString()!);
    uploadroomsstatusrequest = handlingdata(response);

    if (uploadroomsstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print("rooms ------------------->");
        print(response['data']);

        List d = response['data'];
        alladdedrooms.addAll(d.map((e) => RoomModel.fromJson(e)));
      }

      uploadroomsstatusrequest = Statusrequest.success;
      update();
    } else {
      uploadroomsstatusrequest = Statusrequest.failure;
      update();
    }
  }

  addstopsale(String roomid, String start, String end) async {
    addstopsalesstatusrequest = Statusrequest.loading;
    update();
    var response = await stopsaledata.addstopsale(
        hotel!.hotelId.toString()!, roomid, start, end);
    addstopsalesstatusrequest = handlingdata(response);

    if (addstopsalesstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        Get.back(canPop: false);
        onInit();
      } else {
        viewstopsalesstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  void _showSnackbar() {
    Get.snackbar(
      "Successfully ",
      "stop sale period deleted",
      snackPosition: SnackPosition
          .BOTTOM, // You can set the position as per your requirement
      borderRadius:
          8, // You can adjust the border radius as per your requirement
      margin: EdgeInsets.all(
          15), // You can adjust the margin as per your requirement
      backgroundColor: Colors.grey[
          800], // You can set the background color as per your requirement
      colorText:
          Colors.white, // You can set the text color as per your requirement
      duration: Duration(
          seconds: 3), // You can adjust the duration as per your requirement
      isDismissible:
          true, // Set to false if you want to disable dismissing the snackbar by tapping outside
    );
  }

  deletestopsale(String id) async {
    addstopsalesstatusrequest = Statusrequest.loading;
    update();
    var response = await stopsaledata.deletestopsale(id);
    addstopsalesstatusrequest = handlingdata(response);

    if (addstopsalesstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        // Get.back(canPop: false);
        // onInit();

        _showSnackbar();
      } else {
        addstopsalesstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  viewstopsale() async {
    viewstopsalesstatusrequest = Statusrequest.loading;
    update();
    var response = await stopsaledata.viewstopsale(hotel!.hotelId.toString()!);
    viewstopsalesstatusrequest = handlingdata(response);

    if (viewstopsalesstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        List d = response['data'];
        stopsale.addAll(d.map((e) => StopsaleModel.fromJson(e)));
      } else {
        viewstopsalesstatusrequest = Statusrequest.failure;
        update();
      }
    }
    print("frommmmmmmmmmmmmmmmmmmmm view stop sale ");
    print(viewstopsalesstatusrequest);
  }

  @override
  void onInit() async {
    hotel = Get.arguments['hotel'];
    await viewstopsale();

    await getallrooms();

    // TODO: implement onInit
    super.onInit();
  }
}
