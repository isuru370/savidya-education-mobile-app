import 'package:flutter/material.dart';

import '../res/color/app_color.dart';

class BodyTextWidget extends StatelessWidget {
  final String bodyTextTitle;
  final IconData? icon;
  const BodyTextWidget({super.key, required this.bodyTextTitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorUtil.tealColor[10]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        Text(
          bodyTextTitle,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: ColorUtil.whiteColor[10]),
        ),
        Icon(
          icon,
          color: Colors.white,
        )
      ]),
    );
  }
}
