import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

class CustomTextformfieldAuth extends StatefulWidget {
  final String title;
  final String hint;
  final int maxlines;

  final TextEditingController? mycontroller;
  final bool isphone;
  final bool ispassword;
  final String? Function(String?)? valid;

  CustomTextformfieldAuth(
      {super.key,
      required this.title,
      required this.mycontroller,
      this.valid,
      required this.hint,
      this.isphone = false,
      this.maxlines = 1,
      this.ispassword = false});

  @override
  State<CustomTextformfieldAuth> createState() =>
      _CustomTextformfieldAuthState();
}

class _CustomTextformfieldAuthState extends State<CustomTextformfieldAuth> {
  void Function()? ontap;
  bool ishidden = true;
  @override
  Widget build(BuildContext context) {
    return !widget.isphone
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Text(
                    "${widget.title}",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                ),
                child: TextFormField(
                  obscureText: widget.ispassword
                      ? ishidden
                          ? true
                          : false
                      : false,
                  keyboardType: TextInputType.text,
                  maxLines: widget.maxlines,
                  validator: widget.valid,
                  controller: widget.mycontroller,
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    print("complete editing");
                  },
                  decoration: InputDecoration(
                      suffixIcon: widget.ispassword
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  ishidden = !ishidden;
                                });
                              },
                              child: Icon(Icons.remove_red_eye))
                          : null,
                      filled: true,
                      fillColor: AppColors.greytextformfield,
                      hintText: "${widget.hint}",
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(19))),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Text(
                    "${widget.title}",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              IntlPhoneField(
                controller: widget.mycontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.greytextformfield,
                  // labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(19)),
                ),
                initialCountryCode: 'SY',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
            ],
          );
  }
}
