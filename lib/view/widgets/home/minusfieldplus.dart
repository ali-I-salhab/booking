import 'package:booking/core/constants/colors.dart';
import 'package:flutter/material.dart';

class MinusPlus extends StatelessWidget {
  const MinusPlus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Icon(Icons.remove),
        ),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          child: Text("0"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.secondarycolor, width: 2),
          ),
        ),
        Container(
          child: Icon(
            Icons.add,
            color: AppColors.primarycolor,
          ),
        ),
      ],
    );
  }
}
