import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/class_attendance/class_attendance.dart';
import '../../../../services/class_attendance_service/class_attendance_service.dart';

part 'class_attendance_event.dart';
part 'class_attendance_state.dart';

class ClassAttendanceBloc
    extends Bloc<ClassAttendanceEvent, ClassAttendanceState> {
  ClassAttendanceBloc() : super(ClassAttendanceInitial()) {
    on<GetClassAttendanceEvent>((event, emit) async {
      emit(ClassAttendanceProcess());
      try {
        await getClassAttendance(event.classCatId).then(
          (getClassAttendance) {
            if (getClassAttendance['success']) {
              final List<dynamic> getAttendanceData =
                  getClassAttendance['class_attendance_data'];
              final List<ClassAttendanceModelClass> classAttendanceList =
                  getAttendanceData
                      .map((classAttendanceJson) =>
                          ClassAttendanceModelClass.fromJson(
                              classAttendanceJson))
                      .toList();

              emit(GetClassAttendanceSuccess(
                  classAttendanceList: classAttendanceList));
            } else {
              if (getClassAttendance['message'] ==
                  'Failed to class Attendance') {
                emit(ClassAttendanceFailure(
                    failureMessage: getClassAttendance['message']));
              } else if (getClassAttendance['message'] ==
                  'No grades available') {
                emit(const ClassAttendanceFailure(
                    failureMessage: 'There is no data in the database'));
              } else {
                emit(ClassAttendanceFailure(
                    failureMessage: getClassAttendance['message']));
              }
            }
          },
        );
      } catch (e) {
        emit(ClassAttendanceFailure(failureMessage: e.toString()));
      }
    });
    on<ClassAttendanceMarkEvent>((event, emit) async {
      emit(ClassAttendanceProcess());
      try {
        await classAttendanceInsert(event.attendanceModelClass).then(
          (classAttendanceInsert) {
            if (classAttendanceInsert["success"]) {
              emit(const ClassAttendanceInsertSuccess(
                successMessage: "The class started.",
              ));
            } else {
              emit(ClassAttendanceFailure(
                  failureMessage: classAttendanceInsert["message"]));
            }
          },
        );
      } catch (e) {
        emit(ClassAttendanceFailure(failureMessage: e.toString()));
      }
    });
    on<ClassReScheduleEvent>((event, emit) async {
      emit(ClassAttendanceProcess());
      try {
        await reScheduleClass(event.attendanceModelClass).then(
          (reSchedule) {
            if (reSchedule['success']) {
              emit(ClassAttendanceInsertSuccess(
                  successMessage: reSchedule['message']));
            } else {
              emit(ClassAttendanceFailure(
                  failureMessage: reSchedule['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const ClassAttendanceFailure(failureMessage: 'not found'));
      }
    });
  }
}
