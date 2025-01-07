part of 'crop_image_bloc.dart';

sealed class CropImageState extends Equatable {
  const CropImageState();

  @override
  List<Object> get props => [];
}

final class CropImageInitial extends CropImageState {}

final class CropImageFailure extends CropImageState {
  final String? message;
  const CropImageFailure({this.message});
}

final class CropImageProcess extends CropImageState {}

final class CropImageSuccess extends CropImageState {
  final File cropStudentImageFilePath;
  const CropImageSuccess({required this.cropStudentImageFilePath});
}
