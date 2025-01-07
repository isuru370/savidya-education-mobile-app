import 'dart:developer';

import 'package:aloka_mobile_app/src/models/attendance/new%20_attendance_read_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../services/attendance/attendance_service.dart';

part 'new_attendance_read_event.dart';
part 'new_attendance_read_state.dart';

class NewAttendanceReadBloc
    extends Bloc<NewAttendanceReadEvent, NewAttendanceReadState> {
  NewAttendanceReadBloc() : super(NewAttendanceReadInitial()) {
    on<GetAttendanceReadDateEvent>((event, emit) async {
      emit(NewAttendanceReadProcess());
      try {
        await newAttendanceRead(event.studentCustomId).then(
          (readData) {
            if (readData['success']) {
              final List<dynamic> studentReadData = readData['student_data'];
              final List<NewAttendanceReadModel> newAttendanceReadList =
                  studentReadData
                      .map((newReadJson) =>
                          NewAttendanceReadModel.fromJson(newReadJson))
                      .toList();
              emit(NewAttendanceReadSuccess(
                  newAttendanceReadModel: newAttendanceReadList));
            } else {
              emit(NewAttendanceReadFailure(failureMSG: readData['message']));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        emit(const NewAttendanceReadFailure(failureMSG: "data not found"));
      }
    });
  }
}
