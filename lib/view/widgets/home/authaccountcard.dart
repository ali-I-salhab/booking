import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Homepagecard extends StatelessWidget {
  final String text;
  final String image;
  final bool isauth;
  const Homepagecard({
    super.key,
    required this.text,
    required this.image,
    this.isauth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: 10.h,
      child: Stack(
        children: [
          isauth
              ? Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    height: 35,
                    width: 35,
                    child: Image.asset("assets/icons/check.jpg"),
                  ),
                )
              : Container(),
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Colors.black,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      spreadRadius: 2)
                ],
                border: Border.all(color: Colors.black, width: 2),
                // color: const Color.fromRGBO(255, 193, 7, 1),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  image,
                  width: 70,
                  height: 70,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "playfair",
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
