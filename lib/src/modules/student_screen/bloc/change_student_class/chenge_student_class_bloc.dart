import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/student_has_category_has_class/student_has_category_has_class_model.dart';
import '../../../../services/class_has_student_service.dart/class_has_student_service.dart';

part 'chenge_student_class_event.dart';
part 'chenge_student_class_state.dart';

class ChangeStudentClassBloc
    extends Bloc<ChangeStudentClassEvent, ChangeStudentClassState> {
  ChangeStudentClassBloc() : super(ChangeStudentClassInitial()) {
    on<ChangeClassEvent>((event, emit) async {
      emit(ChangeStudentClassProcess());
      try {
        await changeClass(event.modelClass).then(
          (studentClassChange) {
            if (studentClassChange['success']) {
              emit(ChangeStudentClassSuccess(
                  successMessage: studentClassChange['message']));
            } else {
              emit(ChangeStudentClassFailure(
                  failureMessage: studentClassChange['message']));
            }
          },
        );
      } catch (e) {
        emit(
            const ChangeStudentClassFailure(failureMessage: "Failure Message"));
        log(e.toString());
      }
    });
    on<DeleteClassEvent>((event, emit) async {
      emit(ChangeStudentClassProcess());
      try {
        await deleteClass(event.modelClass).then(
          (studentClassDelete) {
            if (studentClassDelete['success']) {
              emit(DeleteStudentClassSuccess(
                  deleteMessage: studentClassDelete['message']));
            } else {
              emit(DeleteStudentClassFailure(
                  deleteFailureMessage: studentClassDelete['message']));
            }
          },
        );
      } catch (e) {
        emit(const DeleteStudentClassFailure(
            deleteFailureMessage: "Failure Message"));
        log(e.toString());
      }
    });
  }
}
