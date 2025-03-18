import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/tute/tute_model.dart';
import '../../../../services/tute/insert_tute.dart';

part 'tute_event.dart';
part 'tute_state.dart';

class TuteBloc extends Bloc<TuteEvent, TuteState> {
  TuteBloc() : super(TuteInitial()) {
    on<InsertTuteEvent>((event, emit) async {});
    on<UpdateTuteEvent>((event, emit) async {});
    on<ClassCategoryTuteEvent>((event, emit) async {});
    on<CheckStudentTuteEvent>((event, emit) async {
      emit(TuteProcessState());
      try {
        await checkStudentTute(
                event.studentId, event.classCategoryId, event.tuteFor)
            .then(
          (checkTute) {
            if (checkTute['success']) {
              emit(CheckTuteSuccessState(
                  chackTute: int.parse(checkTute['tute_count'].toString())));
            } else {
              emit(TuteFailureState(failureMessage: checkTute['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(TuteFailureState(failureMessage: e.toString()));
      }
    });
  }
}
