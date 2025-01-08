import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/camera/crop_image.dart';

part 'crop_image_event.dart';
part 'crop_image_state.dart';

class CropImageBloc extends Bloc<CropImageEvent, CropImageState> {
  CropImageBloc() : super(CropImageInitial()) {
    on<CropImageClickEvent>((event, emit) async {
      emit(CropImageProcess());
      try {
        await cropImage(event.studentImageFilePath).then(
          (cropImageStates) {
            if (cropImageStates != null) {
              File convertFilePath = File(cropImageStates.path);
              emit(CropImageSuccess(cropStudentImageFilePath: convertFilePath));
            } else {
              emit(const CropImageFailure(message: "The image is not cropped"));
            }
          },
        );
      } catch (e) {
        emit(CropImageFailure(message: e.toString()));
      }
    });
  }
}
