import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Extrainfolisttile extends StatelessWidget {
  final String name;
  final String desc;
  final bool val;
  final IoniconsData icon;
  final void Function(bool? val)? onchanged;
  const Extrainfolisttile(
      {super.key,
      required this.name,
      required this.desc,
      this.onchanged,
      required this.val,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.h),
      child: CheckboxListTile(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          subtitle: Text(desc),
          title: Row(
            children: [
              Icon(
                icon,
                weight: 3,
                size: 34.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
          value: val,
          checkColor: AppColors.primarycolor,
          // tileColor: Colors.amber,
          // overlayColor: Colors.accents,
          hoverColor: Colors.red,
          selectedTileColor: Colors.amber,
          onChanged: onchanged),
    );
  }
}
