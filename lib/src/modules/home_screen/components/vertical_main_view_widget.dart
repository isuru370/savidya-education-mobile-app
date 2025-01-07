import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerticalMainViewWidget extends StatelessWidget {
  final void Function()? onTap;
  final String homeIcon1;
  final Icon homeIcon2;
  final String homeText;

  const VerticalMainViewWidget(
      {super.key,
      required this.onTap,
      required this.homeIcon1,
      required this.homeIcon2,
      required this.homeText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            color: ColorUtil.whiteColor[10],
            borderRadius: BorderRadius.circular(12),
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
          child: Center(
            child: ListTile(
              leading: SvgPicture.asset(homeIcon1,
                  height: 58,
                  width: 58,
                  colorFilter: ColorFilter.mode(
                      ColorUtil.blackColor[10]!, BlendMode.srcIn)),
              title: Text(
                homeText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
