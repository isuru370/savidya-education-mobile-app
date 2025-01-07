import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';

class AppMainButton extends StatelessWidget {
  final String testName;
  final double height;
  final Function()? onTap;
  const AppMainButton(
      {super.key,
      required this.testName,
      required this.onTap,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorUtil.tealColor[10]),
              child: Center(
                  child: Text(
                testName,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
