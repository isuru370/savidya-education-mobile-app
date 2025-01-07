import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/teacher/teacher.dart';
import '../../../../services/teacher/teacher.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(TeacherInitial()) {
    on<GetTeacherData>((event, emit) async {
      try {
        await getActiveTeacher().then(
          (activeTeacher) {
            if (activeTeacher['success']) {
              final List<dynamic> teachersData =
                  activeTeacher['get_active_teacher'];
              final List<TeacherModelClass> activeTeacherModel = teachersData
                  .map((teacherJson) => TeacherModelClass.fromJson(teacherJson))
                  .toList();
              emit(GetTeacherSuccess(getActiveTeacherList: activeTeacherModel));
            } else {
              if (activeTeacher['message'] ==
                  'Failed to fetch get active teacher') {
                emit(const GetTeacherSuccess(getActiveTeacherList: []));
              } else {
                emit(GetTeacherFailure(message: activeTeacher['message']));
              }
            }
          },
        );
      } catch (e) {
        emit(const GetTeacherFailure(message: "not found"));
        log(e.toString());
      }
    });
    on<InsertTeacherData>((event, emit) async {
      emit(InsertDataProcess());
      try {
        await insertTeacherData(event.teacherModelClass).then(
          (insertTeacher) {
            if (insertTeacher['success']) {
              emit(InsertDataSuccess(successMessage: insertTeacher['message']));
            } else {
              emit(GetTeacherFailure(message: insertTeacher['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetTeacherFailure(message: "not found"));
        log(e.toString());
      }
    });
    on<UpdateTeacherData>((event, emit) async {
      emit(InsertDataProcess());
      try {
        TeacherModelClass updateTeacher =
            event.teacherModelClass.copyWith(id: event.teacherId);
        await updateTeacherData(updateTeacher).then(
          (updateDate) {
            if (updateDate['success']) {
              emit(InsertDataSuccess(successMessage: updateDate['message']));
            } else {
              emit(GetTeacherFailure(message: updateDate['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetTeacherFailure(message: "not found"));
        log(e.toString());
      }
    });
  }
}
