part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class ImagePickerCameraEvent extends ImagePickerEvent {}

class ImagePickerGalleryEvent extends ImagePickerEvent {}

class ImagePickerCropEvent extends ImagePickerEvent {
  final File studentImageFilePath;
  const ImagePickerCropEvent({required this.studentImageFilePath});
}

class QuickImageUpdateEvent extends ImagePickerEvent {
  final String? quickSearchImage;
  final int? quickImageId;
  const QuickImageUpdateEvent(
      {required this.quickSearchImage, required this.quickImageId});
}

class ClearImageEvent extends ImagePickerEvent {}
