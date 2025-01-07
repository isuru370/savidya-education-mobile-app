part of 'quick_image_bloc.dart';

sealed class QuickImageState extends Equatable {
  const QuickImageState();

  @override
  List<Object> get props => [];
}

final class QuickImageInitial extends QuickImageState {}

final class QuickImageSaveProcess extends QuickImageState {}

final class QuickImageSaveSuccess extends QuickImageState {
  final String? successMessage;
  final String? quickImageId;

  const QuickImageSaveSuccess({
    required this.successMessage,
    required this.quickImageId,

  });
}
final class QuickImageGetSuccess extends QuickImageState {
  final List<QuickImageModel>? quickImageList;
  const QuickImageGetSuccess({
    required this.quickImageList,
  });
}

final class QuickImageSaveFailure extends QuickImageState {
  final String? message;
  const QuickImageSaveFailure({this.message});
}
