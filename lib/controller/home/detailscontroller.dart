import 'dart:io';
import 'package:booking/controller/home/authaccountcontroller.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import 'package:booking/core/class/statusrequest.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/functions/handlingdata.dart';
import 'package:booking/core/services/services.dart';
import 'package:booking/data/datasource/remote/homepage/addhotel.dart';
import 'package:booking/data/model/hotelmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DetailsController extends GetxController {
  List<IconData> hotelIcons = [];
  String iconscode = "000000000000";
  List allhotelicons = [
    {"icon_name": "breakfast", "icon": Icons.free_breakfast},
    {"icon_name": "dinner", "icon": Icons.food_bank},
    {"icon_name": "good view", "icon": Icons.panorama_fish_eye_outlined},
    {"icon_name": "swimming bool", "icon": Icons.water},
    {"icon_name": "sea food", "icon": Icons.settings_accessibility},
    {"icon_name": "sunning", "icon": Icons.reddit}
  ];
  List hoteliconssvg = [
    {"icon_name": "Ac", "icon": ImageAssets.ac, "selected": false},
    {"icon_name": "ATM", "icon": ImageAssets.ATM, "selected": false},
    {"icon_name": "Bar", "icon": ImageAssets.Bar, "selected": false},
    {
      "icon_name": "Fitness centre",
      "icon": ImageAssets.Fitnesscentre,
      "selected": false
    },
    {
      "icon_name": "Beachfront",
      "icon": ImageAssets.Beachfront,
      "selected": false
    },
    {"icon_name": "Parking", "icon": ImageAssets.Parking, "selected": false},
    {
      "icon_name": "Private beach area",
      "icon": ImageAssets.Privatebeacharea,
      "selected": false
    },
    {
      "icon_name": "Reciption",
      "icon": ImageAssets.Reciption,
      "selected": false
    },
    {
      "icon_name": "Restaurants",
      "icon": ImageAssets.Restaurants,
      "selected": false
    },
    {
      "icon_name": "Spaand wellness centre",
      "icon": ImageAssets.Spaandwellnesscentre,
      "selected": false
    },
    {
      "icon_name": "Water Park",
      "icon": ImageAssets.WaterPark,
      "selected": false
    },
    {"icon_name": "Wifi", "icon": ImageAssets.Wifi, "selected": false},
  ];
  bool loading = false;
  File? hotellogo;
  bool imagestatus = false;
  Statusrequest statusrequest = Statusrequest.none;
  Statusrequest updatehotelstatusrequest = Statusrequest.none;

  AddHotelData addhotel = AddHotelData(Get.find());
  TextEditingController? name;
  TextEditingController? namear;
  HotelModel? hotel;
  TextEditingController? desc;
  MyServices myServices = Get.find();

  TextEditingController? descar;
  String lat = "0";
  String long = "0";
  String rating = '0';
  String logo = '0';
  String doc = '0';
  TextEditingController? location;
  String userid = "9";
  AuthaccountinfoController authcontroller = Get.find();
  Future<File> _fileFromImageUrl(String url, String imagename) async {
    final response = await http.get(Uri.parse('$url'));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, '$imagename'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  addhoteldetails() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await addhotel.addhoteldetails(
        iconscode,
        name!.text,
        " namear!.text,",
        desc!.text,
        "descar!.text",
        "logo",
        "long",
        "lat",
        rating,
        "doc",
        location!.text,
        myServices.shared.getString("id").toString(),
        hotellogo!);
    print("response =================> $response");
    statusrequest = handlingdata(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print("here response is $response");
        statusrequest = Statusrequest.success;
        Get.snackbar("Success", "Hotel added");
        Get.delete<DetailsController>();
        Get.offAllNamed(AppRoutes.AuthPage);

        await authcontroller.gethotels();
        update();
      } else {
        Get.defaultDialog(title: "42".tr, middleText: "44".tr);

        statusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  updatehoteldetails(String oldimagename) async {
    print("-----------------------------${hotellogo == null}");
    updatehotelstatusrequest = Statusrequest.loading;
    update();
    var response = await addhotel.updatehoteldetails(
        hotel!.hotelId!.toString(),
        iconscode,
        name!.text.toString(),
        "name in arabic",
        desc!.text.toString(),
        "descar!.text",
        "logo",
        "long",
        "lat",
        rating,
        "doc",
        location!.text.toString(),
        myServices.shared.getString("id").toString(),
        hotellogo,
        oldimagename);
    print("response =================> $response");
    updatehotelstatusrequest = handlingdata(response);

    if (updatehotelstatusrequest == Statusrequest.success) {
      if (response["status"] == "success") {
        print("here response is $response");
        updatehotelstatusrequest = Statusrequest.success;
        update();

        Get.offAllNamed(AppRoutes.AuthPage);

        await authcontroller.gethotels();
      } else {
        Get.defaultDialog(title: "Wrong", middleText: "cant update hotel info");

        updatehotelstatusrequest = Statusrequest.failure;
        update();
      }
    }
  }

  @override
  void onInit() async {
    hotel = Get.arguments == null ? null : Get.arguments['details'];
    // print("Hotel-----------------${hotel!.hotelDesc}");
    name = TextEditingController();

    namear = TextEditingController();

    desc = TextEditingController();

    descar = TextEditingController();
    location = TextEditingController();
    if (hotel != null) {
      name!.text = hotel!.hotelName.toString();
      desc!.text = hotel!.hotelDesc.toString();
      location!.text = hotel!.hotelLocation.toString();
      iconscode = hotel!.hotelIconscode.toString();
      hotellogo = await getimagefrom_url_as_file(
          url: ImageAssets.networkhotellogo + '${hotel!.hotelLogo}');
      loading = true;
      print(
          "upload ing --------------------------------------> 000000000-----100% complete");
      update();

      imagestatus = false;
      // update();
      // hotellogo = await _fileFromImageUrl(
      //     ImageAssets.networkhotellogo + '${hotel!.hotelLogo}',
      //     hotel!.hotelLogo.toString());

      print("--------------------------- hotel logo to file concerting ");
      imagestatus = true;
      for (int i = 0; i < hoteliconssvg.length; i++) {
        print(iconscode[i]);
        if (iconscode[i] == '1') {
          hoteliconssvg[i]['selected'] = true;
        } else {
          hoteliconssvg[i]['selected'] = false;
        }
      }

      update();
    }
    if (hotel == null) {
      print("1");
      loading = true;
      print(
          "upload ing --------------------------------------> 000000000-----100% complete");
      update();
    }
    print("1----------------------------------2");
    // TODO: implement onInit
    super.onInit();
  }
}
