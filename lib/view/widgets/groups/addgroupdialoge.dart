import 'package:booking/controller/home/groupcontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:country_list_picker/country_list_picker.dart';

addgroupdialogue(
  context,
  TextEditingController controller,
  void Function()? onsave,
) {
  GroupController groupcontroller = Get.find();
  showDialog(
      useSafeArea: false,
      context: context,
      builder: (c) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            width: 80.w,
            height: 60.h,
            child: SizedBox(
              height: 40.h,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Add Guest Group",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add Group name",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                      child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.greytextformfield,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Group nationalities"),
                  ),

                  // Column(
                  //   children: [
                  //     ...List.generate(
                  //         3,
                  //         (index) => Container(
                  //               child: Container(
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text("Country"),
                  //                     Transform.scale(
                  //                       scale: 1.2,
                  //                       child: Checkbox(
                  //                           shape: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(18)),
                  //                           value: true,
                  //                           onChanged: (value) {}),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             )),
                  //     SizedBox(height: 2.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     CustomGroupButton(
                  //       text: "save",
                  //       ontap: () {},
                  //       color: AppColors.green,
                  //     ),
                  //     CustomGroupButton(
                  //       text: "cancel",
                  //       ontap: () {
                  //         Get.back(canPop: false);
                  //       },
                  //       color: AppColors.red,
                  //     )
                  //   ],
                  // ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        );
      });
}
