import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';

// ignore: must_be_immutable
class MyMinutesWidget extends StatelessWidget {
  int mins;
  MyMinutesWidget({super.key, required this.mins});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          mins < 10 ? '0$mins' : mins.toString(),
          style:  TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: ColorUtil.blackColor[10]),
        ),
      ),
    );
  }
}
