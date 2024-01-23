import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PaymentCardMethd extends StatelessWidget {
  final bool value;
  final String text;
  const PaymentCardMethd({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          children: [
            Text(text),
            Spacer(),
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: value,
                  onChanged: (val) {}),
            )
          ],
        ));
  }
}
