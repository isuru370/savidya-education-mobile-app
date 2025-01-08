import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/camera/crop_image.dart';
import '../../../../services/camera/image_gallery.dart';
import '../../../../services/camera/quick_camera.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<ImagePickerGalleryEvent>((event, emit) async {
      emit(ImagePickerProcess());
      try {
        await getImageFromGallery().then(
          (imageStates) {
            if (imageStates != null) {
              File imagePath = File(imageStates.path);
              emit(ImagePickerSuccess(
                studentImageUrl: imagePath,
                quickUpdateImage: null,
                quickImageId: null,
              ));
            } else {
              emit(const ImagePickerFailure(
                  message: "Images are not displayed"));
            }
          },
        );
      } catch (e) {
        emit(ImagePickerFailure(message: e.toString()));
      }
    });
    on<ImagePickerCameraEvent>((event, emit) async {
      emit(ImagePickerProcess());
      try {
        await getImageFromCamera().then(
          (imageStates) {
            if (imageStates != null) {
              File imagePath = File(imageStates.path);
              emit(ImagePickerSuccess(
                studentImageUrl: imagePath,
                quickUpdateImage: null,
                quickImageId: null,
              ));
            } else {
              emit(const ImagePickerFailure(
                  message: "Images are not displayed"));
            }
          },
        );
      } catch (e) {
        emit(ImagePickerFailure(message: e.toString()));
      }
    });
    on<ImagePickerCropEvent>((event, emit) async {
      emit(ImagePickerProcess());
      try {
        await cropImage(event.studentImageFilePath).then(
          (imageStates) {
            if (imageStates != null) {
              File imagePath = File(imageStates.path);
              emit(ImagePickerSuccess(
                studentImageUrl: imagePath,
                quickUpdateImage: null,
                quickImageId: null,
              ));
            } else {
              emit(const ImagePickerFailure(
                  message: "Images are not displayed"));
            }
          },
        );
      } catch (e) {
        emit(ImagePickerFailure(message: e.toString()));
      }
    });
    on<QuickImageUpdateEvent>((event, emit) {
      if (event.quickSearchImage != null) {
        emit(ImagePickerSuccess(
          studentImageUrl: null,
          quickUpdateImage: event.quickSearchImage,
          quickImageId: event.quickImageId,
        ));
      } else {
        emit(const ImagePickerFailure(message: "Images are not displayed"));
      }
    });
     on<ClearImageEvent>((event, emit) {
      emit(ImageCleared());
    });
  }
}
