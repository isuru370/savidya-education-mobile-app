import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';

class QuickImageDialogBox extends StatelessWidget {
  final String quickImageId;
  final String quickImageDescription;
  const QuickImageDialogBox(
      {super.key,
      required this.quickImageId,
      required this.quickImageDescription});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          quickImageId,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorUtil.tealColor[10]),
        ),
        Text(
          quickImageDescription,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: ColorUtil.blackColor[10]),
        ),
      ],
    );
  }
}
