import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/student/student.dart';
import '../../../../services/student/students_service.dart';

part 'get_student_event.dart';
part 'get_student_state.dart';

class GetStudentBloc extends Bloc<GetStudentEvent, GetStudentState> {
  GetStudentBloc() : super(GetStudentInitial()) {
    on<GetActiveStudentData>((event, emit) async {
      emit(GetStudentDataProcess());
      try {
        await getActiveStudent().then(
          (getStudentHasClass) {
            if (getStudentHasClass['success']) {
              final List<dynamic> studentHasCLassDataList =
                  getStudentHasClass['get_active_student'];
              final List<StudentModelClass> activeStudentList =
                  studentHasCLassDataList
                      .map((teacherJson) =>
                          StudentModelClass.fromJson(teacherJson))
                      .toList();

              emit(GetAllActiveStudentSuccess(
                activeStudentList: activeStudentList,
              ));
            } else {
              emit(GetStudentDataFailure(
                  failureMessage: getStudentHasClass['message']));
            }
          },
        );
      } catch (e) {
        emit(GetStudentDataFailure(failureMessage: e.toString()));
      }
    });
    on<GetUniqueStudentEvent>((event, emit) async {
      emit(GetStudentDataProcess());
      try {
        await getUniqueStudent(event.studentCustomId).then(
          (getStudentHasClass) {
            if (getStudentHasClass['success']) {
              final List<dynamic> studentHasCLassDataList =
                  getStudentHasClass['get_unique_student'];
              final List<StudentModelClass> activeStudentList =
                  studentHasCLassDataList
                      .map((teacherJson) =>
                          StudentModelClass.fromJson(teacherJson))
                      .toList();

              emit(GetUniqueStudentSuccess(
                getUniqueStudentList: activeStudentList,
              ));
            } else {
              emit(GetStudentDataFailure(
                  failureMessage: getStudentHasClass['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetStudentDataFailure(failureMessage: "not found"));
      }
    });
    on<GetUniqueStudentPercentageEvent>((event, emit) async {
      emit(GetStudentDataProcess());
      try {
        await studentPercentage(
                event.studentId, event.classCategoryHasStudentClassId)
            .then(
          (studentPercentage) {
            if (studentPercentage['success']) {
              if (studentPercentage['present_count'] == "0" &&
                  studentPercentage['absent_count'] == "0" &&
                  studentPercentage['percentage'] == "0.00" &&
                  studentPercentage['attendance_percentage'] == "0.00") {
                emit(GetStudentPercentageSuccess(
                    presentCount: int.parse(
                      studentPercentage['present_count'],
                    ),
                    absentCount: int.parse(
                      studentPercentage['absent_count'],
                    ),
                    percentage: double.parse(
                      studentPercentage['percentage'],
                    ),
                    attendancePercentage: double.parse(
                      studentPercentage['attendance_percentage'],
                    )));
              } else {
                emit(const GetStudentPercentageSuccess(
                    presentCount: 0,
                    absentCount: 0,
                    percentage: 0.00,
                    attendancePercentage: 0.00));
              }
              emit(GetStudentPercentageSuccess(
                  presentCount: int.parse(
                    studentPercentage['present_count'] ?? 0,
                  ),
                  absentCount: int.parse(
                    studentPercentage['absent_count'] ?? 0,
                  ),
                  percentage: double.parse(
                    studentPercentage['percentage'],
                  ),
                  attendancePercentage: double.parse(
                    studentPercentage['attendance_percentage'],
                  )));
            } else {
              emit(GetStudentDataFailure(
                  failureMessage: studentPercentage['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetStudentDataFailure(failureMessage: "Data Not Found"));
        log(e.toString());
      }
    });
    on<UpdateStudentsGrade>((event, emit) async {
      emit(GetStudentDataProcess());
      try {
        await updateStudentGrade(event.studentId, event.gradeId).then(
          (updateStudentGrade) {
            if (updateStudentGrade['success']) {
              emit(const UpdateStudentGradeSuccess(message: "Grade Updated"));
            } else {
              emit(GetStudentDataFailure(
                  failureMessage: updateStudentGrade['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetStudentDataFailure(failureMessage: "Data Not Found"));
        log(e.toString());
      }
    });
  }
}
