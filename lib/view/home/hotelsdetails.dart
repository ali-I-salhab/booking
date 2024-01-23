import 'package:booking/controller/home/authaccountcontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/view/widgets/auth/customtextformfield.dart';
import 'package:booking/view/widgets/home/nextbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Hoteldetails extends StatelessWidget {
  const Hoteldetails({super.key});

  @override
  Widget build(BuildContext context) {
    AuthaccountinfoController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hotel Details "),
      ),
      body: ListView(
        children: [
          Text(
            "Tell us about your hotel",
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(2.w),
            child: TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  label: Text("add hotel description"),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor))),
            ),
          ),
          Text(
            "Tell us about your hotel",
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(2.w),
            child: TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  label: Text("add hotel description"),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primarycolor))),
            ),
          ),
          NextButton(
            ontap: () {
              controller.gotomoreinfo();
            },
          ),
        ],
      ),
    );
  }
}
