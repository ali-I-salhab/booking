import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Update extends StatelessWidget {
  const Update({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pagetitle: "updates"),
      body: ListView(
        children: [
          CustomProfileCard(
              image: ImageAssets.profile,
              flag: ImageAssets.flag,
              name: "ali",
              permition: "permition"),
          Text("Stop sale")
        ],
      ),
    );
  }
}

showaddmealplandialog(
    context, GestureTapCallback onadd, GestureTapCallback oncancel) {
  showDialog(
      context: context,
      builder: (s) {
        return UnconstrainedBox(
          child: Container(
            color: AppColors.primarycolor,
            width: 80.w,
            height: 50.h,
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomGroupButton(
                              text: "add",
                              ontap: () {
                                print("add");
                              },
                              color: AppColors.green),
                          CustomGroupButton(
                              text: "cancel",
                              ontap: () {
                                print("sssssssssssss");
                                oncancel;
                              },
                              color: AppColors.red)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
