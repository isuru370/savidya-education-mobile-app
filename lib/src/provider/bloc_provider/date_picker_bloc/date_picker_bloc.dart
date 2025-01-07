import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../services/defalt_service/date_picker.dart';

part 'date_picker_event.dart';
part 'date_picker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerInitial()) {
    on<BirthdayDatePickerEvent>((event, emit) async {
      try {
        await selectBirthdayDate(event.context).then(
          (birthdayDate) {
            if (birthdayDate != null) {
              emit(DatePikerSuccessState(birthdayDate: birthdayDate));
            } else {
              emit(const DatePickerFailure(
                  message: "Please select your birthday"));
            }
          },
        );
      } catch (e) {
        emit(DatePickerFailure(message: e.toString()));
      }
    });
    on<GraduationYearPicker>((event, emit) async {
      try {
        await selectYearPicker(event.context).then(
          (graduationYear) {
            if (graduationYear != null) {
              emit(YearPikerSuccessState(graduationYear: graduationYear));
            } else {
              emit(const DatePickerFailure(
                  message: "Please select your graduation year"));
            }
          },
        );
      } catch (e) {
        emit(DatePickerFailure(message: e.toString()));
      }
    });
    on<ClassStartDatePicker>((event, emit) async {
      try {
        await selectClassDate(event.context).then(
          (classDate) {
            emit(ClassStartDateSuccessState(
                classStartDate: classDate['select_date'],
                formatDate: classDate['format_date']));
          },
        );
      } catch (e) {
        emit(DatePickerFailure(message: e.toString()));
      }
    });
    on<ClassEndDatePicker>((event, emit) async {
      try {
        await selectClassDate(event.context).then(
          (classDate) {
            emit(ClassEndDateSuccessState(
                classEndDate: classDate['select_date'],
                formatDate: classDate['format_date']));
          },
        );
      } catch (e) {
        emit(DatePickerFailure(message: e.toString()));
      }
    });
    on<FutureDatePickerEvent>((event, emit) async {
      try {
        await selectFutureDate(event.context).then(
          (birthdayDate) {
            if (birthdayDate != null) {
              emit(FutureDatePikerSuccessState(futureDate: birthdayDate));
            } else {
              emit(const DatePickerFailure(message: "Please select your date"));
            }
          },
        );
      } catch (e) {
        emit(DatePickerFailure(message: e.toString()));
      }
    });
  }
}
