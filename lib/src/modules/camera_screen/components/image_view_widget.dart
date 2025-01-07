import 'dart:io';

import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  final File file;
  const ImageViewWidget({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: ColorUtil.whiteColor[10],
          borderRadius: BorderRadius.circular(5),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.file(
            file,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
