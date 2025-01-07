import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';

class StudentSubjectWidget extends StatelessWidget {
  final String circleAvatarText, teacherName, subjectName, gradeName;
  final IconData? trailingIcon;
  final int studentFreeCard;
  final Function() onTap;
  const StudentSubjectWidget(
      {super.key,
      required this.onTap,
      required this.circleAvatarText,
      required this.teacherName,
      required this.subjectName,
      required this.gradeName,
      required this.studentFreeCard,
      required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            circleAvatarText.split("")[0],
            style: TextStyle(color: ColorUtil.whiteColor[10], fontSize: 18),
          ),
        ),
        title: Text(teacherName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subjectName),
            Text(gradeName),
            studentFreeCard == 0
                ? const SizedBox()
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.teal[100], // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      border: Border.all(
                        color: Colors.teal[400]!, // Border color
                        width: 1.5, // Border width
                      ),
                    ),
                    child: const Text(
                      "Free Card",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.teal, // Text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
          ],
        ),
        trailing: InkWell(
          onTap: onTap,
          child: Icon(
            trailingIcon,
            color: ColorUtil.roseColor[10],
          ),
        ),
        tileColor: ColorUtil.whiteColor[12],
        titleTextStyle: TextStyle(
            fontSize: 18,
            color: ColorUtil.blackColor[12],
            fontWeight: FontWeight.w700),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: ColorUtil.blackColor[18]!)),
      ),
    );
  }
}
