import 'dart:developer';

import 'package:aloka_mobile_app/src/models/admission/admission_model_class.dart';
import 'package:aloka_mobile_app/src/services/admission_service/admission_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
