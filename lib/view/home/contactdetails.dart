import 'package:flutter/material.dart';

class Contactdetails extends StatelessWidget {
  const Contactdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: [
            Text(
                "Your full name and phone number are needed to ensure the security of your ALBS.com account")
          ],
        ),
      ),
    );
  }
}
