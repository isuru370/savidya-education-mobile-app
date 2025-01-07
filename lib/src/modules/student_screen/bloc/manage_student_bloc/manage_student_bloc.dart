import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/student/student.dart';
import '../../../../services/camera/upload_image.dart';
import '../../../../services/student/students_service.dart';

part 'manage_student_event.dart';
part 'manage_student_state.dart';

class ManageStudentBloc extends Bloc<ManageStudentEvent, ManageStudentState> {
  ManageStudentBloc() : super(StudentInitial()) {
    on<InsertManageStudentEvent>((event, emit) async {
      emit(StudentDataProcess());
      try {
        if (event.studentImagePath != null) {
          await uploadServerImage(event.studentImagePath).then(
            (studentImageUploaded) async {
              if (studentImageUploaded['path'] != null) {
                StudentModelClass updateStudentModelClass =
                    event.studentModelClass.copyWith(
                  studentImageUrl: studentImageUploaded['path'],
                );
                try {
                  await insertStudentData(updateStudentModelClass).then(
                    (insertStudentData) {
                      emit(StudentDataProcessSuccess(
                          studentId: insertStudentData['student_id'],
                          studentCusId: insertStudentData['student_cus_id'],
                          successMessage: insertStudentData['message']));
                    },
                  );
                } catch (e) {
                  emit(const StudentDataFailure(failureMessage: "not found"));
                  log(e.toString());
                }
              } else {
                emit(StudentDataFailure(
                    failureMessage: studentImageUploaded['message']));
              }
            },
          );
        } else {
          try {
            await insertStudentData(event.studentModelClass).then(
              (insertStudentData) {
                emit(StudentDataProcessSuccess(
                    studentId: insertStudentData['student_id'],
                    studentCusId: insertStudentData['student_cus_id'],
                    successMessage: insertStudentData['message']));
              },
            );
          } catch (e) {
            emit(const StudentDataFailure(failureMessage: "not found"));
            log(e.toString());
          }
        }
      } catch (e) {
        emit(const StudentDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<StudentAddClassEvent>((event, emit) async {
      emit(StudentDataProcess());
      try {
        await studentAddClass(event.studentModelClass).then(
          (addStudentClass) {
            if (addStudentClass['success']) {
              emit(StudentClassAddSuccess(
                  successMessage: addStudentClass['message']));
            } else {
              emit(StudentDataFailure(
                  failureMessage: addStudentClass['message']));
            }
          },
        );
      } catch (e) {
        emit(const StudentDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<UpdateManageStudentEvent>((event, emit) async {
      emit(StudentDataProcess());

      try {
        // Update the student model with the new ID
        StudentModelClass updatedStudentModel =
            event.studentModelClass.copyWith(id: event.studentId);

        if (event.studentImagePath != null) {
          // If there is an image path, upload the image first
          await uploadServerImage(event.studentImagePath).then(
            (studentImageUploaded) {
              if (studentImageUploaded['path'] != null) {
                // If the image upload was successful, update the student model with the new image URL
                updatedStudentModel = updatedStudentModel.copyWith(
                    studentImageUrl: studentImageUploaded['path']);
              } else {
                // If the image upload failed, emit a failure state
                emit(StudentDataFailure(
                    failureMessage: studentImageUploaded['message']));
                return; // Exit early
              }
            },
          );
        }

        // Update the student data with the potentially updated model
        await updateStudentData(updatedStudentModel).then(
          (updateResponse) {
            if (updateResponse['success']) {
              emit(StudentUpDataProcessSuccess(
                  successMessage: updateResponse['message']));
            } else {
              emit(StudentDataFailure(
                  failureMessage: updateResponse['message']));
            }
          },
        );
      } catch (e) {
        emit(const StudentDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
  }
}
