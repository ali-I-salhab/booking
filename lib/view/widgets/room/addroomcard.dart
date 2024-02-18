import 'package:booking/controller/home/roomcontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddRoomCard extends StatefulWidget {
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
  State<AddRoomCard> createState() => _AddRoomCardState();
}

class _AddRoomCardState extends State<AddRoomCard> {
  @override
  int? count;
  Widget build(BuildContext context) {
    if (count == null) {
      count = widget.value;
    }
    print(count);
    RoomController controller = Get.find();
    String val = widget.cardtype == 'guest'
        ? controller.guests[widget.index]['count'].toString()
        : controller.rooms[widget.index]['count'].toString();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(widget.icon),
          SizedBox(
            width: 2.w,
          ),
          Text("${widget.title}"),
          Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if ((count! > 0)) {
                    setState(() {
                      widget.onremove!();
                      count = count! - 1;
                    });
                    print(" $count ------------------");
                  } else {
                    print(" $count -------negative value count -----------");
                  }
                },
                child: Container(
                  width: 10.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color:
                              count! <= 0 ? AppColors.grey : AppColors.blue)),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      color: count! <= 0 ? AppColors.grey : AppColors.blue,
                    ),
                  ),
                ),
              ),
              GetBuilder<RoomController>(builder: (controller) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    width: 10.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.black)),
                    child: Center(
                        child: Text(widget.cardtype == 'guest'
                            ? controller.guests[widget.index]['count']
                                .toString()
                            : controller.rooms[widget.index]['count']
                                .toString())));
              }),
              InkWell(
                onTap: () {
                  setState(() {
                    count = count! + 1;
                    widget.onadd!();
                    print("00000000000000000$count");
                  });
                },
                child: Container(
                  width: 10.w,
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
