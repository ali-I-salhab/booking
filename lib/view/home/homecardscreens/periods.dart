import 'package:booking/controller/home/periodcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/core/functions/deletedailogue.dart';
import 'package:booking/core/soul/animatedprogressbutton.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class Periods extends StatelessWidget {
  Periods({super.key});
  PeriodController controller = Get.put(PeriodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pagetitle: "Periods"),
      body: SafeArea(
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                final date = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                controller.startdate = date!.start.toString().substring(0, 10);
                controller.endate = date!.end.toString().substring(0, 10);
                await controller.addperiod();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageAssets.more,
                    height: 20.sp,
                    width: 20.sp,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.sp),
                    child: Text(
                      "New Period",
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<PeriodController>(builder: (controller) {
              return Handlingdataview(
                  statusrequest: controller.viewperiodstatusrequest,
                  widget: Column(
                    children: [
                      ...List.generate(
                          controller.periods.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PhysicalModel(
                                  borderRadius: BorderRadius.circular(22.sp),
                                  color: Colors.blue.withOpacity(0.5),
                                  shadowColor: Colors.black,
                                  child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      height: 10.h,
                                      width: 80.w,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Text("${index + 1}"),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Text(controller.periods[index]
                                                        ['period_start']
                                                    .toString()
                                                    .substring(0, 10)),
                                                Text(controller.periods[index]
                                                        ['period_end']
                                                    .toString()
                                                    .substring(0, 10))
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  final date =
                                                      await showDateRangePicker(
                                                          confirmText: "update",
                                                          saveText: "update",
                                                          initialDateRange:
                                                              DateTimeRange(
                                                            start: DateTime
                                                                .parse(controller
                                                                    .periods[
                                                                        index][
                                                                        'period_start']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10)),
                                                            end: DateTime.parse(
                                                                controller
                                                                    .periods[
                                                                        index][
                                                                        'period_end']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 10)),
                                                          ),
                                                          context: context,
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2100));

                                                  if (date != null) {
                                                    await controller
                                                        .updateperiod(
                                                            controller.periods[
                                                                    index]
                                                                ['period_id'],
                                                            date!.start
                                                                .toString()
                                                                .substring(
                                                                    0, 10),
                                                            date!.end
                                                                .toString()
                                                                .substring(
                                                                    0, 10));
                                                  }
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.sp),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4.sp),
                                                    padding:
                                                        EdgeInsets.all(7.sp),
                                                    color: AppColors.blue,
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showalertdeletedialogue(
                                                    context,
                                                    () async {
                                                      print("object");
                                                      await controller
                                                          .deleteperiod(
                                                              controller.periods[
                                                                      index][
                                                                  'period_id']);
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.sp),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4.sp),
                                                    padding:
                                                        EdgeInsets.all(7.sp),
                                                    color: AppColors.red,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              ))
                    ],
                  ));
            })
          ],
        ),
      ),
    );
  }
}
