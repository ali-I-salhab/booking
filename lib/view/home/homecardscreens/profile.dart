import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/view/home/homecardscreens/groups.dart';
import 'package:booking/view/widgets/auth/customtextformfield.dart';
import 'package:country_flags/country_flags.dart';
import 'package:country_list_picker/country_list_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.black.withOpacity(0.12),
                margin: EdgeInsets.only(top: 20.sp),
                width: 100.w,
                height: 30.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80.sp,
                      backgroundImage: AssetImage(ImageAssets.profile),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 30.w,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return Container(
                                  height: 50.h,
                                  width: 50.w,
                                  child: Column(
                                    children: [
                                      Text("Select Countryddd"),
                                      SizedBox(
                                        height: 40.h,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: [
                                              ...List.generate(countries.length,
                                                  (index) {
                                                return Container(
                                                  color: Colors.black
                                                      .withOpacity(0.12),
                                                  margin: EdgeInsets.all(10.sp),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(countries[index]
                                                          .name),
                                                      SizedBox(
                                                        width: 30.sp,
                                                      ),
                                                      CountryFlag
                                                          .fromCountryCode(
                                                        countries[index].code,
                                                        height: 50.sp,
                                                        width: 50.sp,
                                                        borderRadius: 180,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CountryFlag.fromCountryCode(
                          'SY',
                          height: 50.sp,
                          width: 50.sp,
                          borderRadius: 180,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 30.w,
                        child: PhysicalModel(
                          color: Colors.transparent,
                          shadowColor: Colors.black,
                          elevation: 10.sp,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ))),
                        ))
                  ],
                ),
              ),
              Profilecard(
                name: 'name',
                image: ImageAssets.person,
              ),
              Profilecard(
                name: 'email',
                image: ImageAssets.email,
              ),
              Profilecard(
                name: 'password',
                image: ImageAssets.password,
              ),
              Profilecard(
                name: 'phone',
                image: ImageAssets.phone,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Profilecard extends StatelessWidget {
  final String name;
  final String image;

  const Profilecard({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.sp, left: 10.sp),
            child: Row(
              children: [
                Text(name),
              ],
            ),
          ),
          Container(
            width: 100.w,
            child: Stack(
              children: [
                SizedBox(
                  width: 60.w,
                  child: PhysicalModel(
                    borderRadius: BorderRadius.circular(20.sp),
                    elevation: 10.sp,
                    color: Colors.white,
                    child: SizedBox(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 55.w,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hoverColor: Colors.red,
                                    isCollapsed: false,
                                    labelStyle: TextStyle(color: Colors.blue),
                                    focusColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                                initialValue: "ali salhab",
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.sp,
                  top: 4.sp,
                  child: PhysicalModel(
                      color: Colors.transparent,
                      elevation: 22.sp,
                      shadowColor: Colors.black.withOpacity(0.12),
                      child: Container(
                        height: 35.sp,
                        width: 35.sp,
                        child: SvgPicture.asset(image),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
