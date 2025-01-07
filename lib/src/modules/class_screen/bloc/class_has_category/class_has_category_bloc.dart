import 'dart:developer';

import 'package:aloka_mobile_app/src/models/class_schedule/class_has_category_model_class.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/category_has_class/category_has_class.dart';
import '../../../../services/class_has_category_service/class_has_category_service.dart';

part 'class_has_category_event.dart';
part 'class_has_category_state.dart';

class ClassHasCategoryBloc
    extends Bloc<ClassHasCategoryEvent, ClassHasCategoryState> {
  ClassHasCategoryBloc() : super(ClassHasCategoryInitial()) {
    on<InsertClassHasCategory>((event, emit) async {
      emit(ClassHasCategoryProcess());
      try {
        await insertClassCategory(event.classHasCatModelClass).then(
          (insertCategoryData) {
            if (insertCategoryData['success']) {
              emit(ClassHasCategorySuccess(
                  successMessage: insertCategoryData['message']));
            } else {
              emit(ClassHasCategoryFailure(
                  failureMessage: insertCategoryData['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassHasCategoryFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<GetAllClassHasCategory>(
      (event, emit) async {
        emit(ClassHasCategoryProcess());
        try {
          await getClassHasCategory().then(
            (getCatHasClass) {
              if (getCatHasClass['success']) {
                final List<dynamic> categoryData =
                    getCatHasClass['get_class_has_category'];
                final List<ClassHasCategoryModelClass> classHasCategoryList =
                    categoryData
                        .map((classHasCatJson) =>
                            ClassHasCategoryModelClass.fromJson(
                                classHasCatJson))
                        .toList();
                emit(GetClassHasCategorySuccess(
                    allClassHasCatList: classHasCategoryList));
              } else {
                emit(ClassHasCategoryFailure(
                    failureMessage: getCatHasClass['message']));
              }
            },
          );
        } catch (e) {
          emit(const ClassHasCategoryFailure(failureMessage: "not found"));
          log(e.toString());
        }
      },
    );
    on<ClassHasCategoryClassEvent>((event, emit) async {
      emit(ClassHasCategoryProcess());
      try {
        await getAllTheoryAnRevision().then(
          (theoryRevisionData) {
            if (theoryRevisionData['success']) {
              final List<dynamic> theoryRevisionDataList =
                  theoryRevisionData['theory_revision'];
              final List<ClassHasCategoryModelClass> tRList =
                  theoryRevisionDataList
                      .map((theoryRevisionJson) =>
                          ClassHasCategoryModelClass.fromJson(
                              theoryRevisionJson))
                      .toList();
              emit(ClassTheoryAndRevisionSuccess(theoryAnRevisionList: tRList));
            } else {
              emit(ClassHasCategoryFailure(
                  failureMessage: theoryRevisionData['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassHasCategoryFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<GetUniqueClassHasCatEvent>((event, emit) async {
      emit(ClassHasCategoryProcess());
      try {
        await getUniqueClassCategory(event.classId).then(
          (uniqueClassHasCatData) {
            if (uniqueClassHasCatData['success']) {
              final List<dynamic> uniqueClassHasCatList =
                  uniqueClassHasCatData['get_unique_class_category'];
              final List<ClassHasCategoryModelClass> tRList =
                  uniqueClassHasCatList
                      .map((theoryRevisionJson) =>
                          ClassHasCategoryModelClass.fromJson(
                              theoryRevisionJson))
                      .toList();
              emit(GetUniqueClassHasCatSuccess(uniqueClassHasCatList: tRList));
            } else {
              emit(ClassHasCategoryFailure(
                  failureMessage: uniqueClassHasCatData['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassHasCategoryFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
  }
}
