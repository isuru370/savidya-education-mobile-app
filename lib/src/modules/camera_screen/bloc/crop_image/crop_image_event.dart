part of 'crop_image_bloc.dart';

sealed class CropImageEvent extends Equatable {
  const CropImageEvent();

  @override
  List<Object> get props => [];
}

class CropImageClickEvent extends CropImageEvent {
  final File studentImageFilePath;
  const CropImageClickEvent({
    required this.studentImageFilePath,
  });
}
