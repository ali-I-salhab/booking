import 'package:booking/controller/home/authaccountcontroller.dart';
import 'package:booking/core/constants/colors.dart';
import 'package:booking/view/widgets/home/extrainfolisttile.dart';
import 'package:booking/view/widgets/home/nextbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Moreinfo extends StatelessWidget {
  const Moreinfo({super.key});

  @override
  Widget build(BuildContext context) {
    Map services = {
      0: {
        "name": "Room Services",
        "desc": "good services in rooms",
        "value": false
      },
      1: {"name": "Bar", "desc": "", "value": false},
      2: {"name": "Sauna", "desc": "", "value": false},
      3: {"name": "Fitness center", "desc": "", "value": false},
      4: {"name": "No_smoking Room", "desc": "", "value": false},
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Extra Info"),
      ),
      body: Container(
        padding: EdgeInsets.all(2.w),
        child: GetBuilder<AuthaccountinfoController>(
          builder: (controller) => Column(
            children: [
              Text("Select available Services  in your Hotels"),
              Expanded(
                  child: ListView(
                children: [
                  ...List.generate(
                      services.length,
                      (index) => Extrainfolisttile(
                            icon: Ionicons.add_circle_outline,
                            onchanged: (b) {
                              print(b);
                              print(index);
                              services[index]['value'] =
                                  !services[index]['value'];
                              controller.update();
                              print(services);
                            },
                            name: services[index]['name'],
                            desc: services[index]['desc'],
                            val: services[index]['value'],
                          ))
                ],
              )),
              NextButton(
                ontap: () {
                  controller.gotohomepage();
                },
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
