import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/student/students_in_the_class_mode.dart';
import '../../../../services/student/students_service.dart';

part 'student_in_the_class_event.dart';
part 'student_in_the_class_state.dart';

class StudentInTheClassBloc
    extends Bloc<StudentInTheClassEvent, StudentInTheClassState> {
  StudentInTheClassBloc() : super(StudentInTheClassInitial()) {
    on<GetStudentInTheClassEvent>((event, emit) async {
      emit(StudentInTheClassProcess());
      try {
        await studentInTheClass(event.studentClassId, event.studentHasCatId)
            .then(
          (studentInTheClass) {
            if (studentInTheClass['success']) {
              final List<dynamic> studentInTheClassDate =
                  studentInTheClass['get_student_in_the_class'];
              final List<StudentsInTheClassModel> studentInTheClassList =
                  studentInTheClassDate
                      .map((studentClassJson) =>
                          StudentsInTheClassModel.fromJson(studentClassJson))
                      .toList();
              emit(StudentInTheClassSuccess(
                  studentInTheClassModel: studentInTheClassList));
            } else {
              emit(StudentInTheClassFailure(
                  failureMessage: studentInTheClass['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const StudentInTheClassFailure(failureMessage: "Date not found"));
      }
    });
  }
}
