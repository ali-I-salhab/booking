import 'package:booking/controller/home/paymentcontroller.dart';
import 'package:booking/core/class/handlingdataview.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:booking/view/widgets/auth/authtextformfield.dart';
import 'package:booking/view/widgets/groups/customgroupbutton.dart';
import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:booking/view/widgets/home/customprofilecard.dart';
import 'package:booking/view/widgets/payment/paymentmethodcard.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentController controller = Get.put(PaymentController());
    return Scaffold(
      appBar: CustomAppBar(pagetitle: "Payment"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomProfileCard(
              image: ImageAssets.profile,
              flag: ImageAssets.flag,
              name: 'alisalhab',
              permition: 'admin',
            ),
            SizedBox(
              height: 70.h,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Text("sdsdsd"),
                  ),
                  InkWell(
                    onTap: () {
                      showaddpaymentdialogue(context, () async {
                        await controller.addpayment();
                      }, () {
                        Get.back(canPop: false);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.h,
                          width: 4.h,
                          child: Image.asset(ImageAssets.more),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text("Add Payment gateway")
                      ],
                    ),
                  ),
                  GetBuilder<PaymentController>(builder: (controller) {
                    return Handlingdataview(
                        statusrequest: controller.fullpagestatusrequest,
                        widget: Container(
                            // height: 30.h,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      blurRadius: 2,
                                      spreadRadius: 5)
                                ]),
                            child: Column(
                              children: [
                                ...List.generate(controller.payments.length,
                                    (index) {
                                  return InkWell(
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  Text("delete this content ?"),
                                              actions: [
                                                CustomGroupButton(
                                                    text: "ok",
                                                    ontap: () {
                                                      String id = controller
                                                          .payments[index]
                                                          .paymentId!;
                                                      controller.payments
                                                          .removeAt(index);
                                                      controller.delete(
                                                          id!, context);
                                                      controller.update();
                                                      Get.back(canPop: false);
                                                    },
                                                    color: AppColors.green),
                                                CustomGroupButton(
                                                    text: "cancel",
                                                    ontap: () {
                                                      Get.back(canPop: false);
                                                    },
                                                    color: AppColors.red)
                                              ],
                                            );
                                          });
                                    },
                                    child: Paymentcard(
                                      name: controller
                                          .payments[index].paymentName!,
                                      company: controller
                                          .payments[index].paymentCompany!,
                                      groupname: controller
                                          .payments[index].paymentGuestgroup!,
                                      api: controller
                                          .payments[index].paymentApi!,
                                      token: controller
                                          .payments[index].paymentToken!,
                                      desc: controller
                                          .payments[index].paymentMarchentuser!,
                                    ),
                                  );
                                })
                              ],
                            )));
                  }),
                  // Column(
                  //   children: [
                  //     ...List.generate(
                  //         5,
                  //         (index) =>
                  //             PaymentCardMethd(value: true, text: "paypal$index"))
                  //   ],
                  // )
                  /**Container(
                        // height: 30.h,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 2,
                              spreadRadius: 5)
                        ]),
                        child: Column(
                          children: [
                            ...List.generate(controller.payments.length, (index) {
                              return Paymentcard(
                                name: controller.payments[index].paymentName!,
                                company: controller.payments[index].paymentCompany!,
                                groupname:
                                    controller.payments[index].paymentGuestgroup!,
                                api: controller.payments[index].paymentApi!,
                                token: controller.payments[index].paymentToken!,
                                desc:
                                    controller.payments[index].paymentMarchentuser!,
                              );
                            })
                          ],
                        )) */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Paymentcard extends StatelessWidget {
  final String name;
  final String company;
  final String groupname;
  final String api;
  final String token;
  final String desc;

  const Paymentcard({
    super.key,
    required this.name,
    required this.company,
    required this.groupname,
    required this.api,
    required this.token,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.blue,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.08),
      ),
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.all(10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageAssets.kashier),
              Spacer(
                flex: 2,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [Text(name), Text(desc)],
                ),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
          DataTable(columns: [
            DataColumn(
              label: Text('Groups'),
            ),
            DataColumn(
              label: Text('Currency'),
            ),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('Russina And Ukrania')),
              DataCell(Text("\$")),
            ]),
          ]),
          Text("desc :  $desc"),
          Text("api :  $api"),
          Text("token :  $token"),
        ],
      ),
    );
  }
}

showaddpaymentdialogue(
    context, GestureTapCallback onadd, void Function() oncancel) {
  PaymentController controller = Get.find();
  showDialog(
      context: context,
      builder: (s) {
        return UnconstrainedBox(
          child: Container(
            color: AppColors.primarycolor,
            width: 80.w,
            height: 90.h,
            child: Material(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    4.sp, 4.sp, 4.sp, MediaQuery.of(context).viewInsets.bottom),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New payment gateway",
                            style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    CustomTextformfieldAuth(
                      title: "payment name",
                      hint: "Enter Payment name",
                      mycontroller: controller.name,
                    ),
                    Text("Slect group"),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (s) {
                              return Dialog(
                                child: Container(
                                  height: 20.h,
                                  width: 10.w,
                                  color: Colors.white,
                                  child: ListView(
                                    children: [
                                      Text(
                                        "select group",
                                        textAlign: TextAlign.center,
                                      ),
                                      ...List.generate(
                                        controller.alladdedgroups.length,
                                        (index) => ListTile(
                                          onTap: () {
                                            // controller.roomid = controller
                                            //     .alladdedrooms[index]!.roomId!;
                                            controller.guestgroup =
                                                controller.handleddata[index]
                                                    ['group_name']!;
                                            print(
                                                "controlller guest group selected value is ---------->${controller.guestgroup}");
                                            controller.update();
                                            Get.back(canPop: false);
                                          },
                                          title: Text(
                                              controller.handleddata[index]
                                                  ["group_name"]!),
                                          leading: Icon(Ionicons.locate),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.sp,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(14.sp)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 4.sp,
                            ),
                            Icon(Icons.arrow_drop_down_circle_sharp),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.sp),
                              color: AppColors.black,
                              width: 2.sp,
                              height: 30.sp,
                            ),
                            GetBuilder<PaymentController>(
                                builder: (controller) {
                              return controller.guestgroup == null
                                  ? Text("Select type")
                                  : Text(controller.guestgroup!);
                            })
                          ],
                        ),
                      ),
                    ),
                    Text("Slect payment company"),
                    Row(
                      children: [
                        UnconstrainedBox(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10.sp,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.sp,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(14.sp)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 4.sp,
                                ),
                                Icon(Icons.arrow_drop_down_circle_sharp),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 8.sp),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  color: AppColors.black,
                                  width: 2.sp,
                                  height: 30.sp,
                                ),
                                GetBuilder<PaymentController>(
                                    builder: (controller) {
                                  return Row(
                                    children: [
                                      Text("كاشير "),
                                      Image.asset(
                                        ImageAssets.kashier,
                                        width: 40.sp,
                                        height: 40.sp,
                                      )
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(8)),
                          width: 12.w,
                          height: 15.w,
                          child: Center(
                            child: Text(
                              "15%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    CustomTextformfieldAuth(
                      maxlines: 1,
                      title: "Description",
                      hint: "Enter payment description",
                      mycontroller: controller.marchentuser,
                    ),
                    CustomTextformfieldAuth(
                      // maxlines: 5,
                      title: " api",
                      hint: "Enter your api",
                      mycontroller: controller.token,
                    ),
                    CustomTextformfieldAuth(
                      title: "token",
                      hint: "Enter your token",
                      // isphone: true,
                      mycontroller: controller.api,
                    ),
                    GetBuilder<PaymentController>(builder: (controller) {
                      return Handlingdataview(
                          statusrequest: controller.addpaymentstatusrequest,
                          widget: Container(
                            margin: EdgeInsets.all(2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomGroupButton(
                                    text: "add",
                                    ontap: onadd,
                                    color: AppColors.green),
                                CustomGroupButton(
                                    text: "cancel",
                                    ontap: oncancel,
                                    color: AppColors.red)
                              ],
                            ),
                          ));
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
