import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AnimatedProgressButton extends StatefulWidget {
  const AnimatedProgressButton({super.key});

  @override
  State<AnimatedProgressButton> createState() => _AnimatedProgressButtonState();
}

class _AnimatedProgressButtonState extends State<AnimatedProgressButton> {
  @override
  bool isloading = true;
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      child: ElevatedButton(

          // style: ElevatedButton.styleFrom(minimumSize: sized,shape: StadiumBorder()),
          onPressed: () {},
          child: isloading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text("alisalhab")),
    );
  }
}
