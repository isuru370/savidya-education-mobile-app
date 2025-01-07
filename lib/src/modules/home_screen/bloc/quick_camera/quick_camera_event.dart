part of 'quick_camera_bloc.dart';

sealed class QuickCameraEvent extends Equatable {
  const QuickCameraEvent();

  @override
  List<Object> get props => [];
}

class QuickCameraClickEvent extends QuickCameraEvent{}