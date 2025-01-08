import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/admission/admission_model_class.dart';
import '../../../../services/admission_service/admission_service.dart';

part 'admission_event.dart';
part 'admission_state.dart';

class AdmissionBloc extends Bloc<AdmissionEvent, AdmissionState> {
  AdmissionBloc() : super(AdmissionInitial()) {
    on<AddAdmissionEvent>((event, emit) async {
      emit(AddAdmissionProcess());
      try {
        await insertAdmissionData(event.admissionModelClass).then(
          (insertData) {
            if (insertData['success']) {
              emit(AddAdmissionSuccess(successMessage: insertData['message']));
            } else {
              emit(AddAdmissionFailure(failureMessage: insertData['message']));
            }
          },
        );
      } catch (e) {
        emit(const AddAdmissionFailure(failureMessage: "failureMessage"));
        log(e.toString());
      }
    });
  }
}
