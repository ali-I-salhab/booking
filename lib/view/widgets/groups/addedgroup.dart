import 'package:booking/core/constants/colors.dart';
import 'package:booking/core/constants/imageassets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class AddedGuestGroup extends StatelessWidget {
  final String name;
  final Country flag;

  final void Function()? ontapedit;
  final void Function()? ontapdelete;

  const AddedGuestGroup(
      {super.key,
      required this.name,
      this.ontapedit,
      this.ontapdelete,
      required this.flag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Transform.scale(
            scale: 1.9,
            child: Text(flag.flagEmoji),
          ),
          Row(
            children: [
              InkWell(
                onTap: ontapedit,
                child: Container(
                    margin: EdgeInsets.only(right: 4.w),
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(180)),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )),
              ),
              InkWell(
                onTap: ontapdelete,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(180)),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
