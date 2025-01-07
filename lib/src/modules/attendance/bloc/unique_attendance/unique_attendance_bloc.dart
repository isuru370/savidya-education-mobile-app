import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/attendance/attendance.dart';
import '../../../../services/attendance/attendance_service.dart';

part 'unique_attendance_event.dart';
part 'unique_attendance_state.dart';

class UniqueAttendanceBloc
    extends Bloc<UniqueAttendanceEvent, UniqueAttendanceState> {
  UniqueAttendanceBloc() : super(UniqueAttendanceInitial()) {
    on<GetUniqueStudentAttendanceEvent>((event, emit) async {
      emit(UniqueAttendanceProcess());
      try {
        await getStudentUniqueAttendance(
          event.studentId,
          event.classCategoryHasStudentClassId,
        ).then(
          (getAttendanceUnique) {
            if (getAttendanceUnique['success']) {
              List<dynamic> attendanceStu = getAttendanceUnique['data'];
              final List<GetStudentAttendanceModelClass> attendanceStuList =
                  attendanceStu
                      .map((json) =>
                          GetStudentAttendanceModelClass.fromJson(json))
                      .toList();
              emit(UniqueAttendanceSuccess(modelAttendance: attendanceStuList));
            } else {
              emit(UniqueAttendanceFailure(
                  failureMessage: getAttendanceUnique['message']));
            }
          },
        );
      } catch (e) {
        emit(const UniqueAttendanceFailure(failureMessage: "Not Found"));
        log(e.toString());
      }
    });
  }
}
