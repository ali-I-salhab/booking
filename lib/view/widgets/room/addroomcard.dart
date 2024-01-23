import 'package:booking/controller/home/roomcontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddRoomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final controller;
  final void Function()? onadd;
  final int value;
  final int index;
  final void Function()? onremove;
  final String cardtype;

  const AddRoomCard({
    super.key,
    required this.title,
    required this.icon,
    this.onadd,
    this.onremove,
    required this.value,
    this.controller,
    required this.index,
    required this.cardtype,
  });

  @override
  Widget build(BuildContext context) {
    RoomController controller = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          SizedBox(
            width: 2.w,
          ),
          Text("$title"),
          Spacer(),
          Row(
            children: [
              InkWell(
                onTap: onremove,
                child: Container(
                  width: 6.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.blue)),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ),
              GetBuilder<RoomController>(builder: (controller) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  width: 6.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.black)),
                  child: Center(
                      child: Text(cardtype == 'guest'
                          ? controller.guests[index]['count'].toString()
                          : controller.rooms[index]['count'].toString())),
                );
              }),
              InkWell(
                onTap: onadd,
                child: Container(
                  width: 6.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.blue)),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
