import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHoursWidget extends StatelessWidget {
  int hours;
  MyHoursWidget({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          hours.toString(),
          style:  TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: ColorUtil.blackColor[10] ),
        ),
      ),
    );
  }
}
