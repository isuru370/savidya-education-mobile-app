import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../services/camera/quick_camera.dart';

part 'quick_camera_event.dart';
part 'quick_camera_state.dart';

class QuickCameraBloc extends Bloc<QuickCameraEvent, QuickCameraState> {
  QuickCameraBloc() : super(QuickCameraInitial()) {
    on<QuickCameraClickEvent>((event, emit) async {
      emit(QuickCameraProcess());
      try {
        await getImageFromCamera().then(
          (imageStates) {
            if (imageStates != null) {
              File imagePath = File(imageStates.path);
              emit(QuickCameraSuccess(imageResult: imagePath));
            } else {
              emit(const QuickCameraFailure(
                  massage: "Images are not displayed"));
            }
          },
        );
      } catch (e) {
        emit(QuickCameraFailure(massage: e.toString()));
      }
    });
  }
}
