import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/admission/admission_model_class.dart';
import '../../../../services/admission_service/admission_service.dart';

part 'get_admission_event.dart';
part 'get_admission_state.dart';

class GetAdmissionBloc extends Bloc<GetAdmissionEvent, GetAdmissionState> {
  GetAdmissionBloc() : super(GetAdmissionInitial()) {
    on<GetAdmission>((event, emit) async {
      emit(GetAdmissionProcess());
      try {
        await getAdmission().then(
          (getAdmission) {
            if (getAdmission['success']) {
              final List<dynamic> admissionData =
                  getAdmission['admission_data'];
              final List<AdmissionModelClass> admissionList = admissionData
                  .map((gradeJson) => AdmissionModelClass.fromJson(gradeJson))
                  .toList();

              emit(GetAdmissionSuccess(admissionModel: admissionList));
            } else {
              emit(GetAdmissionFailure());
            }
          },
        );
      } catch (e) {
        emit(GetAdmissionFailure());
        log(e.toString());
      }
    });
  }
}
