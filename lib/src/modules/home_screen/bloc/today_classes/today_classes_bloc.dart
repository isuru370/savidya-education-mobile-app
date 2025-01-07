import 'dart:developer';

import 'package:aloka_mobile_app/src/models/class_attendance/today_classes_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../services/class_attendance_service/class_attendance_service.dart';

part 'today_classes_event.dart';
part 'today_classes_state.dart';

class TodayClassesBloc extends Bloc<TodayClassesEvent, TodayClassesState> {
  TodayClassesBloc() : super(TodayClassesInitial()) {
    on<GetTodayClassEvent>((event, emit) async {
      emit(TodayClassesProcess());
      try {
        await getTodayClasses(event.selectDate).then(
          (todayClasses) {
            if (todayClasses['success']) {
              final List<dynamic> todayClassData =
                  todayClasses['today_classes'];
              final List<TodayClassesModel> todayClassesList = todayClassData
                  .map((todayCLassesJson) =>
                      TodayClassesModel.fromJson(todayCLassesJson))
                  .toList();
              emit(TodayClassesSuccess(todayClassesModel: todayClassesList));
            } else {
              emit(TodayClassesFailure(failureMSG: todayClasses['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const TodayClassesFailure(failureMSG: "Data not found"));
      }
    });
  }
}
