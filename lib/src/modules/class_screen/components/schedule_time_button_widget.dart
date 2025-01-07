import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';

class ScheduleTimeButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  const ScheduleTimeButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ColorUtil.blackColor[16]!)),
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ));
  }
}
