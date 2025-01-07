import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';

class SearchQuickImageList extends StatelessWidget {
  final Function() onTap;
  final String networkQuickImageUrl;
  final String quickImageId, quickImageCreateAt, studentGrade;
  const SearchQuickImageList({
    super.key,
    required this.onTap,
    required this.networkQuickImageUrl,
    required this.quickImageId,
    required this.quickImageCreateAt,
    required this.studentGrade,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: ColorUtil.whiteColor[14],
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    networkQuickImageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Image Id : $quickImageId',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorUtil.blackColor[10]),
                    ),
                    Text(
                      'Create At : $quickImageCreateAt',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorUtil.blackColor[10]),
                    ),
                    Text(
                      "Grade : $studentGrade",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorUtil.blackColor[10]),
                    )
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: ColorUtil.tealColor[10],
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1, color: ColorUtil.blackColor[10]!)),
                  child: Icon(
                    Icons.add,
                    color: ColorUtil.whiteColor[10],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
