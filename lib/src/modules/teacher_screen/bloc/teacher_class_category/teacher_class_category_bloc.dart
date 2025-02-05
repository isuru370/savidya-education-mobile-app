import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/teacher/teacher_class_category_model.dart';
import '../../../../services/teacher/teacher.dart';

part 'teacher_class_category_event.dart';
part 'teacher_class_category_state.dart';

class TeacherClassCategoryBloc
    extends Bloc<TeacherClassCategoryEvent, TeacherClassCategoryState> {
  TeacherClassCategoryBloc() : super(TeacherClassCategoryInitial()) {
    on<GetTeacherClassCategoryEvent>((event, emit) async {
      emit(TeacherClassCategoryProcess());
      try {
        await teacherClassCategory(event.teacherClassId).then(
          (teacherClassCat) {
            if (teacherClassCat['success']) {
              final List<dynamic> teacherClassCatData =
                  teacherClassCat['get_teacher_class_category'];
              final List<TeacherClassCategoryModel> teacherClassCatList =
                  teacherClassCatData
                      .map((teacherClassCatJson) =>
                          TeacherClassCategoryModel.fromJson(teacherClassCatJson))
                      .toList();
              emit(TeacherClassCategorySuccess(
                  teacherClassCategoryModel: teacherClassCatList));
            } else {
              emit(TeacherClassCategoryFailure(
                  failureMessage: teacherClassCat['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const TeacherClassCategoryFailure(
            failureMessage: "Data not found"));
      }
    });
  }
}
