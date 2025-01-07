import 'dart:developer';

import 'package:aloka_mobile_app/src/services/class_shedule_service/class_shedule_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/class_schedule/class_halle_model.dart';

part 'class_halls_event.dart';
part 'class_halls_state.dart';

class ClassHallsBloc extends Bloc<ClassHallsEvent, ClassHallsState> {
  ClassHallsBloc() : super(ClassHallsInitial()) {
    on<ClassHallsEvent>((event, emit) async {
      try {
        await getHall().then(
          (getHalls) {
            if (getHalls['success']) {
              List<dynamic> hallList = getHalls["hall_data"];
              final classHallData = hallList
                  .map(
                    (e) => ClassHalleModelClass.fromJson(e),
                  )
                  .toList();
              emit(GetClassHallsSuccess(classHallList: classHallData));
            } else {
              emit(GetClassHallsFailure(failureMessage: getHalls['message']));
            }
          },
        );
      } catch (e) {
        emit(const GetClassHallsFailure(failureMessage: "not found"));
        log(e.toString());
      }
    });
  }
}
