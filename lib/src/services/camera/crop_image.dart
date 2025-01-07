import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

import '../../res/color/app_color.dart';

Future<CroppedFile?> cropImage(File studentImageFilePath) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: studentImageFilePath.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Image Crop',
          toolbarColor: ColorUtil.blueColor[10],
          toolbarWidgetColor: ColorUtil.whiteColor[10],
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Image Crop',
      ),
    ],
  );
  if (croppedFile != null) {
    return croppedFile;
  } else {
    return null;
  }
}
