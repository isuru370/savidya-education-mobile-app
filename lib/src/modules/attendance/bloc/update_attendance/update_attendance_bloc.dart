import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/attendance/attendance_service.dart';

part 'update_attendance_event.dart';
part 'update_attendance_state.dart';

class UpdateAttendanceBloc
    extends Bloc<UpdateAttendanceEvent, UpdateAttendanceState> {
  UpdateAttendanceBloc() : super(UpdateAttendanceInitial()) {
    on<UpdateAttendance>((event, emit) async {
      emit(UpdateAttendanceProcess());
      try {
        await updateStudentAttendance(event.classAttendanceId, event.atDate,
                event.studentId, event.studentHasClassId)
            .then(
          (updated) {
            if (updated['success']) {
              emit(UpdateAttendanceSuccess(successMessage: updated['message']));
            } else {
              emit(UpdateAttendanceFailure(errorMessage: updated['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const UpdateAttendanceFailure(errorMessage: "errorMessage"));
      }
    });
  }
}
