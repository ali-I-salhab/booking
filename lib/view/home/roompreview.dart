import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/view/home/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sizer/sizer.dart';

class RoomPreview extends StatelessWidget {
  const RoomPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Container(
                width: 100.w,
                height: 40.h,
                child: Image.asset(
                  ImageAssets.room,
                  fit: BoxFit.fill,
                )),
          ),
          Positioned(
              top: 39.h,
              child: Container(
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                    color: AppColors.primarycolor,
                    gradient: LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topCenter,
                        colors: [AppColors.primarycolor, AppColors.white]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18))),
                width: 100.w,
                height: 70.h,
                child: Column(
                  children: [
                    Text(
                      "Room on the forest ",
                      style: GoogleFonts.aclonica(color: AppColors.white),
                    ),
                    Text(
                      "Double Room",
                      textAlign: TextAlign.end,
                      style: GoogleFonts.aclonica(color: AppColors.white),
                    ),
                    Text(
                      "good room with three bed two for adults and one for child good services with abi;ity to change provife fint sd a ",
                      style: GoogleFonts.aclonica(
                          color: AppColors.black, fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Location :    ",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        ),
                        Text("forest of egypt   "),
                        Row(
                          children: [
                            Text(
                              "Google map",
                              style: GoogleFonts.aclonica(
                                  color: AppColors.secondarycolor),
                            ),
                            Icon(Icons.location_history,
                                color: AppColors.secondarycolor)
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Rating :    ",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        ),
                        RatingStars(
                          editable: false,
                          rating: 3.5,
                          color: Colors.amber,
                          iconSize: 32,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Guests :",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "2",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "beds :",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "three beds ",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "bathroom :",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "private path room",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "quantity :",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "2",
                          style: GoogleFonts.aclonica(color: AppColors.white),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        width: 40.w,
                        child: Chip(
                            backgroundColor: AppColors.secondarycolor,
                            avatar: Icon(
                              Icons.price_change,
                              color: AppColors.white,
                            ),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "price :",
                                  style: GoogleFonts.aclonica(
                                      color: AppColors.white),
                                ),
                                Text(
                                  "12\$",
                                  style:
                                      GoogleFonts.aclonica(color: Colors.red),
                                )
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              AppColors.secondarycolor),
                        ),
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.homepage);
                          Get.snackbar("Success", "room  add succesfuly ",
                              // backgroundColor: AppColors.secondarycolor,
                              icon: Icon(
                                Icons.check_box,
                                color: Colors.green,
                                size: 30.sp,
                              ),
                              duration: Duration(seconds: 5));
                        },
                        child: Container(
                          // color: AppColors.black,
                          child: Text(
                            "Confirme",
                            style: GoogleFonts.aclonica(color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
