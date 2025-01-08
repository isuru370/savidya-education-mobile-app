import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../../models/camera/quick_image_model.dart';
import '../../../../services/camera/upload_image.dart';

part 'quick_image_event.dart';
part 'quick_image_state.dart';

class QuickImageBloc extends Bloc<QuickImageEvent, QuickImageState> {
  QuickImageBloc() : super(QuickImageInitial()) {
    on<QuickImageSaveEvent>((event, emit) async {
      emit(QuickImageSaveProcess());
      try {
        await uploadServerImage(event.quickImageFilePath).then(
          (quickImageSaveStates) async {
            if (quickImageSaveStates['path'] != null) {
              QuickImageModel updateQuickImage = event.quickImageModel.copyWith(
                quickImg: quickImageSaveStates['path'],
              );
              try {
                await uploadImageData(updateQuickImage).then(
                  (insertQuickImageData) {
                    if (insertQuickImageData['success']) {
                      emit(QuickImageSaveSuccess(
                        successMessage: insertQuickImageData['message'],
                        quickImageId: insertQuickImageData['quickImageId'],
                      ));
                    } else {
                      emit(QuickImageSaveFailure(
                          message: insertQuickImageData['message']));
                    }
                  },
                );
              } catch (e) {
                emit(QuickImageSaveFailure(message: e.toString()));
              }
            } else {
              emit(QuickImageSaveFailure(
                  message: quickImageSaveStates['message']));
            }
          },
        );
      } catch (e) {
        emit(QuickImageSaveFailure(message: e.toString()));
      }
    });
    on<GetAllQuickImageEvent>(
      (event, emit) async {
        emit(QuickImageSaveProcess());
        try {
          await getAllQuickImage().then(
            (getAllQuickImages) {
              if (getAllQuickImages['success']) {
                List<QuickImageModel> quickImageModel =
                    (getAllQuickImages['data'] as List)
                        .map((data) => QuickImageModel.fromJson(data))
                        .toList();
                emit(QuickImageGetSuccess(quickImageList: quickImageModel));
              } else {
                emit(QuickImageSaveFailure(
                    message: getAllQuickImages['message']));
              }
            },
          );
        } catch (e) {
          emit(QuickImageSaveFailure(message: e.toString()));
        }
      },
    );
  }
}
