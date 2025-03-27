import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/tute/tute_model.dart';
import '../../../../services/tute/tute_service.dart';

part 'tute_event.dart';
part 'tute_state.dart';

class TuteBloc extends Bloc<TuteEvent, TuteState> {
  TuteBloc() : super(TuteInitial()) {
    on<InsertTuteEvent>((event, emit) async {
      emit(TuteProcessState());
      try {
        await insertTute(event.studentId, event.classCategoryId, event.tuteFor)
            .then((insertTute) {
          if (insertTute['success']) {
            emit(InsertTuteSuccessState(successMessage: insertTute['message']));
          } else {
            emit(TuteFailureState(failureMessage: insertTute['message']));
          }
        });
      } catch (e) {
        log(e.toString());
        emit(TuteFailureState(failureMessage: e.toString()));
      }
    });
    on<UpdateTuteEvent>((event, emit) async {});
    on<ClassCategoryTuteEvent>((event, emit) async {
      emit(TuteProcessState());
      try {
        await getStudentTute(event.studentId, event.classCategoryId)
            .then((tute) {
          if (tute['tute_count'] is List) {
            final List<TuteModelClass> tuteList = (tute['tute_count'] as List)
                .map((item) =>
                    TuteModelClass.fromJson(Map<String, dynamic>.from(item)))
                .toList();

            emit(GetStudentTuteSuccessState(tuteModelClass: tuteList));
          } else {
            emit(const TuteFailureState(failureMessage: 'Invalid data format'));
          }
        });
      } catch (e) {
        log(e.toString());
        emit(TuteFailureState(failureMessage: e.toString()));
      }
    });
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
    on<CheckStudentTuteCountEvent>((event, emit) async {
      emit(TuteProcessState());
      try {
        await checkStudentTuteChack(event.tuteFor, event.studentId,
                event.studentStudentClassId, event.classCategoryId)
            .then(
          (checkTute) {
            if (checkTute['success']) {
              emit(GetStudentTuteChackSuccessState(
                  paymentCount:
                      int.parse(checkTute['payment_count'].toString()),
                  tuteCount: int.parse(checkTute['tute_count'].toString())));
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
