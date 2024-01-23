import 'package:booking/view/widgets/home/customappbar.dart';
import 'package:flutter/material.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: ListView(
        children: [Text("Room Details")],
      ),
    );
  }
}
