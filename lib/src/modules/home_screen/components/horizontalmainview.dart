import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class HorizontalMainViewWidget extends StatelessWidget {
  void Function()? onTap;
  final String icon;
  final String text;
  final ColorFilter colorFilter;
  HorizontalMainViewWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.colorFilter});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorUtil.whiteColor[10],
          boxShadow: [
            BoxShadow(
              color: ColorUtil.whiteColor[16]!,
              blurRadius: 12.0,
              spreadRadius: 2.0,
              offset: const Offset(
                2.0,
                2.0,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 58,
                  width: 58,
                  colorFilter: colorFilter,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
