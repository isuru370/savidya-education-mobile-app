part of 'quick_camera_bloc.dart';

sealed class QuickCameraState extends Equatable {
  const QuickCameraState();

  @override
  List<Object> get props => [];
}

final class QuickCameraInitial extends QuickCameraState {}

final class QuickCameraFailure extends QuickCameraState {
  final String massage;
  const QuickCameraFailure({required this.massage});
}

final class QuickCameraProcess extends QuickCameraState {}

final class QuickCameraSuccess extends QuickCameraState {
  final File imageResult;
  const QuickCameraSuccess({required this.imageResult});
}
