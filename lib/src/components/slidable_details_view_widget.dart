import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableDetailsViewWidget extends StatelessWidget {
  final Function(BuildContext) onTap;
  final String contend;
  final String subContend;
  final String joinDate;
  final IconData icon;
  final Widget circleWidget;
  final String? imageUrl;
  final String? circleText;
  const SlidableDetailsViewWidget({
    super.key,
    required this.onTap,
    required this.contend,
    required this.subContend,
    required this.joinDate,
    required this.icon,
    required this.circleWidget,
    this.imageUrl,
    this.circleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: onTap,
            icon: icon,
            backgroundColor: ColorUtil.skyBlueColor[10]!,
            borderRadius: BorderRadius.circular(5.0),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorUtil.whiteColor[10],
              border: Border.all(width: 0.3, color: ColorUtil.whiteColor[18]!),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: ColorUtil.whiteColor[12]!,
                  blurRadius: 12.0,
                  spreadRadius: 2.0,
                  offset: const Offset(
                    2.0,
                    2.0,
                  ),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                circleWidget,
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contend,
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorUtil.blackColor[10],
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        subContend,
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorUtil.blackColor[10],
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        joinDate,
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorUtil.blackColor[10],
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
