import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';

class MyAmorPmWidget extends StatelessWidget {
  final bool isItAml;
  const MyAmorPmWidget({super.key, required this.isItAml});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          isItAml == true ? 'AM' : 'PM',
          style:  TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: ColorUtil.blackColor[10]),
        ),
      ),
    );
  }
}
