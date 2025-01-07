import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/attendance/class_student_attendance_mode.dart';
import '../../../../services/attendance/attendance_service.dart';

part 'class_student_attendance_event.dart';
part 'class_student_attendance_state.dart';

class ClassStudentAttendanceBloc
    extends Bloc<ClassStudentAttendanceEvent, ClassStudentAttendanceState> {
  ClassStudentAttendanceBloc() : super(ClassStudentAttendanceInitial()) {
    on<GetClassStudentAttendance>(_handleGetClassStudentAttendance);
  }

  Future<void> _handleGetClassStudentAttendance(
    GetClassStudentAttendance event,
    Emitter<ClassStudentAttendanceState> emit,
  ) async {
    emit(ClassStudentAttendanceProcess());
    try {
      final result = await classStudentAttendance(event.classStudentAttendanceMode);

      if (result['success']) {
        final List<dynamic> resultData = result['data'];
        final List<ClassStudentAttendanceMode> attendanceList = resultData
            .map((json) => ClassStudentAttendanceMode.fromJson(json))
            .toList();
        emit(ClassStudentAttendanceSuccess(
            classStudentAttendanceList: attendanceList));
      } else {
        emit(ClassStudentAttendanceFailure(
            errorMessage: result['message'] ?? "An unknown error occurred"));
      }
    } catch (e) {
      log("Error fetching class student attendance: $e");
      emit(const ClassStudentAttendanceFailure(
          errorMessage: "Failed to fetch attendance data. Please try again."));
    }
  }
}
