import 'dart:developer';

import 'package:aloka_mobile_app/src/services/attendance/attendance_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendance_count_event.dart';
part 'attendance_count_state.dart';

class AttendanceCountBloc
    extends Bloc<AttendanceCountEvent, AttendanceCountState> {
  AttendanceCountBloc() : super(AttendanceCountInitial()) {
    on<CountAttendanceEvent>((event, emit) async {
      emit(AttendanceCountProcess());
      try {
        await getAttendanceCount(
                event.date, event.studentStudentClassId, event.studentId)
            .then(
          (attendanceCount) {
            if (attendanceCount['success']) {
              emit(AttendanceCountSuccess(
                  attendanceCount: attendanceCount['attendance_count'] is int
                      ? attendanceCount['attendance_count']
                      : int.parse(
                          attendanceCount['attendance_count'].toString())));
            } else {
              emit(AttendanceCountFailure(
                  failureMessage: attendanceCount['message']));
            }
          },
        );
      } catch (e) {
        emit(const AttendanceCountFailure(
            failureMessage: "Failed the attendance count"));
        log(e.toString());
      }
    });
  }
}
