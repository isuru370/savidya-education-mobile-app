part of 'image_picker_bloc.dart';

sealed class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object?> get props => [];
}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickerProcess extends ImagePickerState {}

final class ImagePickerFailure extends ImagePickerState {
  final String message;
  const ImagePickerFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ImagePickerSuccess extends ImagePickerState {
  final File? studentImageUrl;
  final String? quickUpdateImage;
  final int? quickImageId;
  const ImagePickerSuccess(
      {required this.studentImageUrl,
      required this.quickUpdateImage,
      required this.quickImageId});

  @override
  List<Object?> get props => [studentImageUrl, quickUpdateImage, quickImageId];
}

final class ImageCleared extends ImagePickerState {
  @override
  List<Object?> get props => [];
}
