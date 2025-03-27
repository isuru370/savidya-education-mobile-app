import 'dart:developer';

import 'package:aloka_mobile_app/src/models/payment_model_class/last_payment_model_class.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/student/students_in_the_class_mode.dart';
import '../../../../services/class_shedule_service/class_shedule_service.dart';
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
    on<GetStudentAllClassEvent>((event, emit) async {
      emit(StudentInTheClassProcess());
      try {
        await getStudentClass(event.studentId).then((studentClass) {
          if (studentClass['success']) {
            final List<dynamic> studentClassDate =
                studentClass['student_class_data'];
            final List<LastPaymentModelClass> studentClassList =
                studentClassDate
                    .map((studentClassJson) =>
                        LastPaymentModelClass.fromJson(studentClassJson))
                    .toList();
            emit(UnicStudentAllClass(studentInTheClassModel: studentClassList));
          } else {
            emit(StudentInTheClassFailure(
                failureMessage: studentClass['message']));
          }
        });
      } catch (e) {
        log(e.toString());
        emit(const StudentInTheClassFailure(failureMessage: "Date not found"));
      }
    });
  }
}
