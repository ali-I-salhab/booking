import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/data/datasource/remote/homepage/perioddata.dart';
import 'package:booking/data/datasource/remote/homepage/perioddata.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeriodController extends GetxController {
  PeriodsData periodsdata = PeriodsData(Get.find());
  Statusrequest addperiodstatusrequest = Statusrequest.none;
  Statusrequest viewperiodstatusrequest = Statusrequest.none;
  Statusrequest updateperiodstatusrequest = Statusrequest.none;
  Statusrequest deleteperiodstatusrequest = Statusrequest.none;

  late HotelModel hotel;
  String? startdate;
  String? endate;
  List periods = [];
  addperiod() async {
    addperiodstatusrequest = Statusrequest.loading;

    update();
    var response =
        await periodsdata.addperiod(hotel.hotelId!, startdate!, endate!);
    addperiodstatusrequest = handlingdata(response);

    if (addperiodstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        await viewperiod();
      } else {
        addperiodstatusrequest = Statusrequest.failure;
        update();
      }
    } else {
      Get.snackbar("Error", "Check internet connection");
    }
  }

  updateperiod(String periodid, String start, String end) async {
    updateperiodstatusrequest = Statusrequest.loading;

    update();
    var response = await periodsdata.editperiod(periodid, start!, end!);
    updateperiodstatusrequest = handlingdata(response);

    if (updateperiodstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        await viewperiod();
      } else {
        Get.snackbar("Error",
            "uncorrect server request make sure yo add correct information");
        updateperiodstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  deleteperiod(String periodid) async {
    deleteperiodstatusrequest = Statusrequest.loading;

    update();
    var response = await periodsdata.deleteperiod(periodid);
    deleteperiodstatusrequest = handlingdata(response);

    if (deleteperiodstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        periods.removeWhere((element) => element['period_id'] == periodid);
        update();
      } else {
        Get.snackbar("Error",
            "uncorrect server request make sure yo add correct information");
        updateperiodstatusrequest = Statusrequest.failure;
        update();
      }
    } else {
      Get.snackbar("Connection error", "");
    }
  }

  viewperiod() async {
    viewperiodstatusrequest = Statusrequest.loading;

    update();
    var response = await periodsdata.viewperiod(hotel.hotelId!);
    viewperiodstatusrequest = handlingdata(response);

    update();

    if (viewperiodstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        periods = response['data'];
        print(periods);
      } else {
        viewperiodstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  @override
  void onInit() {
    hotel = Get.arguments['hotel'];
    viewperiod();
    // TODO: implement onInit
    super.onInit();
  }
}
