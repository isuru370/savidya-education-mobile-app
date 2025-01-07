import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/color/app_color.dart';
import 'dialog_camera_button_widget.dart';

class ChooserWidget extends StatelessWidget {
  final Function() galleryTap, cameraTap, cropImageTap;
  final File? isStudentImage;
  const ChooserWidget({
    super.key,
    required this.galleryTap,
    required this.cameraTap,
    required this.cropImageTap,
    required this.isStudentImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text('Your choice'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DialogCameraButtonWidget(
                icon: 'assets/svg/gallery.svg',
                colorFilter: ColorFilter.mode(
                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                text: "Gallery",
                onTap: galleryTap),
            const SizedBox(
              width: 10,
            ),
            DialogCameraButtonWidget(
                icon: 'assets/svg/quickcamera.svg',
                colorFilter: ColorFilter.mode(
                    ColorUtil.blackColor[10]!, BlendMode.srcIn),
                text: "Camera",
                onTap: cameraTap),
            const SizedBox(
              width: 10,
            ),
            isStudentImage != null
                ? DialogCameraButtonWidget(
                    icon: 'assets/svg/quickcamera.svg',
                    colorFilter: ColorFilter.mode(
                        ColorUtil.blackColor[10]!, BlendMode.srcIn),
                    text: "Crop",
                    onTap: cropImageTap)
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
