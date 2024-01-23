import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/data/model/roommodel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddedRoomcard extends StatelessWidget {
  final RoomModel roomModel;
  const AddedRoomcard({super.key, required this.roomModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(1),
      // color: Colors.red,
      margin: EdgeInsets.only(top: 4.h),
      height: 20.h,
      child: Row(
        children: [
          UnconstrainedBox(
            child: Container(
              height: 10.h,
              width: 20.w,
              // margin: EdgeInsets.only(right: 2),
              decoration: BoxDecoration(
                  color: AppColors.greytextformfield,
                  border:
                      Border.all(width: 2, color: AppColors.greytextformfield),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                ImageAssets.room,
                fit: BoxFit.fill,
              ),
            ),
          ),
          UnconstrainedBox(
            child: Container(
              // color: AppColors.blue,
              width: 63.w,
              height: 20.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 1.h,
                    left: 2.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 15.w, child: const Text("Guests")),
                        Container(
                          // padding: EdgeInsets.all(2),

                          width: 15.w,
                          height: 5.h,
                          child: Text(
                            (int.parse(roomModel.roomChildrenundersix!) +
                                    int.parse(
                                        roomModel.roomChildrenundertwelf!) +
                                    int.parse(roomModel.roomAdult!) +
                                    int.parse(roomModel.roomInfant!))
                                .toString(),
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8.5.h,
                    left: 2.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 15.w,
                          child: const Text(
                            "groups",
                          ),
                        ),
                        Container(
                          // color: AppColors.green,
                          width: 15.w,
                          height: 8.h,
                          child: Text(
                            roomModel.roomGroupguest.toString(),
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    left: 20.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 18.w,
                          child: const Text(
                            "beds",
                          ),
                        ),
                        Container(
                          width: 18.w,
                          height: 8.h,
                          child: const Text(
                            "2",
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 1.h,
                    left: 20.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: const Text("availabilty"),
                          width: 18.w,
                        ),
                        Container(
                          width: 18.w,
                          height: 4.h,
                          child: Text(
                            roomModel.roomAvailbility.toString(),
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 1.h,
                    left: 40.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 18.w, child: const Text("meal Plan")),
                        Container(
                          // color: AppColors.green,
                          width: 18.w,
                          height: 4.h,
                          child: const Text(
                            "12\$",
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    left: 40.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: 22.w, child: const Text("Current Rate")),
                        Container(
                          // color: AppColors.green,
                          width: 22.w,
                          height: 8.h,
                          child: Text(
                            roomModel.roomRate.toString(),
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      left: 18.w,
                      child: Container(
                        width: 2,
                        height: 20.h,
                        color: AppColors.greytextformfield,
                      )),
                  Positioned(
                      left: 39.w,
                      child: Container(
                        width: 2,
                        height: 20.h,
                        color: AppColors.greytextformfield,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
