import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/class_schedule/class_schedule.dart';
import '../../../../services/class_shedule_service/class_shedule_service.dart';

part 'class_bloc_event.dart';
part 'class_bloc_state.dart';

class ClassBlocBloc extends Bloc<ClassBlocEvent, ClassBlocState> {
  ClassBlocBloc() : super(ClassBlocInitial()) {
    on<InsertClassData>((event, emit) async {
      emit(ClassDataProcess());
      try {
        await insertClassData(event.studentClassModel).then(
          (classDataInsert) {
            if (classDataInsert['success']) {
              emit(
                ClassDataSuccess(
                  successMessage: classDataInsert['message'],
                  classId: classDataInsert['class_id'],
                ),
              );
            } else {
              emit(
                  ClassDataFailure(failureMessage: classDataInsert['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<GetActiveClass>((event, emit) async {
      emit(ClassDataProcess());
      try {
        await getActiveClass().then(
          (getActiveClass) {
            if (getActiveClass['success']) {
              final List<dynamic> getActiveClassList =
                  getActiveClass['get_active_class_data'];
              final List<ClassScheduleModelClass> activeStudentClassModel =
                  getActiveClassList
                      .map((classJson) =>
                          ClassScheduleModelClass.fromJson(classJson))
                      .toList();

              emit(GetActiveClassSuccess(
                  studentModelClass: activeStudentClassModel));
            } else {
              if (getActiveClass['message'] == 'No data found') {
                emit(const GetActiveClassSuccess(studentModelClass: []));
              }
              emit(ClassDataFailure(failureMessage: getActiveClass['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<GetOngoingClass>((event, emit) async {
      emit(ClassDataProcess());
      try {
        await getOngoingClass().then(
          (getActiveClass) {
            if (getActiveClass['success']) {
              final List<dynamic> getActiveClassList =
                  getActiveClass['get_active_and_ongoing_data'];
              final List<ClassScheduleModelClass> activeStudentClassModel =
                  getActiveClassList
                      .map((classJson) =>
                          ClassScheduleModelClass.fromJson(classJson))
                      .toList();

              emit(GetOngoingSuccess(
                  studentModelClass: activeStudentClassModel));
            } else {
              if (getActiveClass['message'] == 'No data found') {
                emit(const GetActiveClassSuccess(studentModelClass: []));
              }
              emit(ClassDataFailure(failureMessage: getActiveClass['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
    on<UpdateClassDataEvent>((event, emit) async {
      emit(ClassDataProcess());
      try {
        await updateClassData(event.studentClassModel).then(
          (classDataInsert) {
            if (classDataInsert['success']) {
              emit(
                ClassDataUpdated(
                  updateMessage: classDataInsert['message'],
                ),
              );
            } else {
              emit(
                  ClassDataFailure(failureMessage: classDataInsert['message']));
            }
          },
        );
      } catch (e) {
        emit(const ClassDataFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
  }
}
