import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class StudentImageAreaWidget extends StatelessWidget {
  final DecorationImage? decorationImage;
  final Function() onPressed;
  final String buttonName;
  const StudentImageAreaWidget({
    super.key,
    required this.onPressed,
    required this.buttonName,
    required this.decorationImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            image: decorationImage,
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          width: 150,
          height: 150,
        ),
        Column(
          children: [
            ElevatedButton(onPressed: onPressed, child: Text(buttonName)),
          ],
        ),
      ],
    );
  }
}
