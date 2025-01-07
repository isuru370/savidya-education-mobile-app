import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';

class AppSubButton extends StatelessWidget {
  final String testName;
  final double height;
  final Function()? onTap;
  const AppSubButton(
      {super.key,
      required this.testName,
      required this.onTap,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorUtil.tealColor[10]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    testName,
                    style: TextStyle(
                      color: ColorUtil.whiteColor[10],
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  color: ColorUtil.whiteColor[10],
                  size: 20,
                  Icons.arrow_right_alt,
                ),
              ],
            )),
      ),
    );
  }
}
