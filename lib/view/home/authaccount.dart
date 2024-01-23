import 'package:booking/controller/home/authaccountcontroller.dart';
import 'package:booking/controller/home/detailscontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/functions/alertexitapp.dart';
import 'package:booking/core/functions/showbottomsheet.dart';
import 'package:booking/core/functions/uploadfile.dart';
import 'package:booking/view/widgets/auth/customauthbutton.dart';
import 'package:booking/view/widgets/auth/customtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/authaccountcard.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:booking/view/widgets/home/nextbutton.dart';
import 'package:booking/view/widgets/hotelsunderyouraccount.dart';
import 'package:booking/view/widgets/prefered/animatedlikebutton.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sizer/sizer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthaccountinfoController controller = Get.put(AuthaccountinfoController());
    return WillPopScope(
      onWillPop: () {
        return alertexitpp();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: CustomAppBar(),
          body: Container(
            margin: EdgeInsets.all(1.w),
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.gethotels();
              },
              child: ListView(
                children: [
                  CustomProfileCard(
                      image: ImageAssets.profile,
                      flag: ImageAssets.flag,
                      name: "name",
                      permition: "permition"),
                  Center(
                      child: Text(
                    "Hotels And Apartments \n Under Your Account ",
                    style: GoogleFonts.poppins(fontSize: 22.sp),
                  )),
                  GetBuilder<AuthaccountinfoController>(builder: (controller) {
                    return UnderyourAccount(
                      title: 'My Hotels',
                      images: [
                        ImageAssets.available,
                      ],
                      ontapadd: () {
                        Get.toNamed(AppRoutes.details);
                      },
                      hotelmodel: controller.hotels,
                    );
                  })
                  // UnderyourAccount(
                  //   title: 'api',
                  //   images: [],
                  //   ontapadd: () async {
                  //     await controller.gethotels();
                  //     // Get.toNamed(AppRoutes.homepage);
                  //   },
                  // ),
                  // UnderyourAccount(
                  //   title: 'apartments',
                  //   images: [],
                  //   ontapadd: () {},
                  // ),
                  // UnderyourAccount(
                  //   title: 'Hotels',
                  //   images: [],
                  //   ontapadd: () {},
                  // ),
                  // Text("sdsds"),
                  // LikeButton()
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       // color: Colors.red,
                  //       border: Border.all(color: Colors.black)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //           width: 48.0,
                  //           height: 48.0,
                  //           decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               image: DecorationImage(
                  //                   fit: BoxFit.fill,
                  //                   image: AssetImage("assets/icons/egypt.png")))),
                  //       Text(
                  //         "ALBS",
                  //         style:
                  //             TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // CustomTextFormField(
                  //     label: "اسم الفندق",
                  //     valid: (val) {},
                  //     icon: Icons.hotel_class_outlined,
                  //     mycontroller: controller.hotename,
                  //     hint: "الرجاء ادخال اسم الفندق باللغة العربية",
                  //     isnumeric: false),
                  // SizedBox(
                  //   height: 3.h,
                  // ),
                  // CustomTextFormField(
                  //     label: "hotel name",
                  //     valid: (val) {},
                  //     icon: Icons.hotel_class_outlined,
                  //     mycontroller: controller.hotename,
                  //     hint: "Enter your hotel name in endlish language ",
                  //     isnumeric: false),
                  // SizedBox(
                  //   height: 3.h,
                  // ),
                  // GetBuilder<AuthaccountinfoController>(builder: (controller) {
                  //   return controller.imagefile == null
                  //       ? GestureDetector(
                  //           child: Container(
                  //             margin: EdgeInsets.symmetric(horizontal: 10.w),
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                     color: AppColors.primarycolor, width: 1),
                  //                 color: AppColors.secondarycolor,
                  //                 borderRadius: BorderRadius.circular(18)),
                  //             padding: const EdgeInsets.all(10),
                  //             child: const Center(
                  //               child: Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   Text("select hotel logo "),
                  //                   Icon(Icons.image)
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           onTap: () {
                  //             showbottomsheet(() async {
                  //               controller.imagefile = await imageuploadcamera();
                  //               controller.update();
                  //               Get.back(canPop: false);
                  //             }, () async {
                  //               controller.imagefile = await fileuploadgalllery();
                  //               controller.update();
                  //               Get.back(canPop: false);
                  //             });
                  //           },
                  //         )
                  //       : InkWell(
                  //           onTap: () {
                  //             showbottomsheet(() async {
                  //               controller.imagefile = await imageuploadcamera();
                  //               controller.update();
                  //               Get.back(canPop: false);
                  //             }, () async {
                  //               controller.imagefile = await fileuploadgalllery();
                  //               controller.update();
                  //               Get.back(canPop: false);
                  //             });
                  //           },
                  //           child: Container(
                  //             width: 30.w,
                  //             height: 30.h,
                  //             child: Image.file(controller.imagefile!),
                  //           ),
                  //         );
                  // }),

                  // SizedBox(
                  //   height: 3.h,
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(10),
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const Text("Select your country"),
                  //       IconButton(
                  //         onPressed: () {
                  //           showCountryPicker(
                  //             context: context,
                  //             showPhoneCode:
                  //                 true, // optional. Shows phone code before the country name.
                  //             onSelect: (Country country) {
                  //               controller.countryname.value =
                  //                   country.displayNameNoCountryCode;
                  //               controller.countryflag.value = country.flagEmoji;
                  //               String a = country.flagEmoji;
                  //             },
                  //           );
                  //         },
                  //         icon: const Icon(Icons.pin_drop),
                  //       ),
                  //       Obx(() => Row(
                  //             // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(controller.countryflag.value),
                  //               SizedBox(
                  //                 width: 1.w,
                  //               ),
                  //               Text(controller.countryname.value),
                  //             ],
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // const Text(
                  //   "Select Hotel Rating ",
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // RatingStars(
                  //   editable: true,
                  //   rating: 3.5,
                  //   color: Colors.amber,
                  //   iconSize: 32,
                  // ),
                  // SizedBox(
                  //   height: 2.h,
                  // ),

                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // NextButton(
                  //   ontap: () {
                  //     controller.gotogooglemap();
                  //   },
                  // ),
                  // // const Text("All rights reserved.Copyright (2006-2023) – ALBS ™"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
