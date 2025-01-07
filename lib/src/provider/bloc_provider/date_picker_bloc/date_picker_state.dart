part of 'date_picker_bloc.dart';

sealed class DatePickerState extends Equatable {
  const DatePickerState();

  @override
  List<Object> get props => [];
}

final class DatePickerInitial extends DatePickerState {}

final class DatePikerSuccessState extends DatePickerState {
  final String birthdayDate;
  const DatePikerSuccessState({required this.birthdayDate});
  @override
  List<Object> get props => [birthdayDate];
}

final class FutureDatePikerSuccessState extends DatePickerState {
  final String futureDate;
  const FutureDatePikerSuccessState({required this.futureDate});
  @override
  List<Object> get props => [futureDate];
}

final class YearPikerSuccessState extends DatePickerState {
  final String graduationYear;
  const YearPikerSuccessState({required this.graduationYear});
  @override
  List<Object> get props => [graduationYear];
}

final class ClassStartDateSuccessState extends DatePickerState {
  final DateTime classStartDate;
  final String formatDate;
  const ClassStartDateSuccessState({
    required this.classStartDate,
    required this.formatDate,
  });
  @override
  List<Object> get props => [classStartDate, formatDate];
}

final class ClassEndDateSuccessState extends DatePickerState {
  final DateTime classEndDate;
  final String formatDate;
  const ClassEndDateSuccessState({
    required this.classEndDate,
    required this.formatDate,
  });
  @override
  List<Object> get props => [classEndDate, formatDate];
}

final class DatePickerFailure extends DatePickerState {
  final String message;
  const DatePickerFailure({required this.message});

  @override
  List<Object> get props => [message];
}
