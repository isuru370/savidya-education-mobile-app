part of 'date_picker_bloc.dart';

sealed class DatePickerEvent extends Equatable {
  const DatePickerEvent();

  @override
  List<Object> get props => [];
}

class BirthdayDatePickerEvent extends DatePickerEvent {
  final BuildContext context;
  const BirthdayDatePickerEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class FutureDatePickerEvent extends DatePickerEvent {
  final BuildContext context;
  const FutureDatePickerEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class GraduationYearPicker extends DatePickerEvent {
  final BuildContext context;
  const GraduationYearPicker({required this.context});

  @override
  List<Object> get props => [context];
}

class ClassStartDatePicker extends DatePickerEvent {
  final BuildContext context;
  const ClassStartDatePicker({required this.context});

  @override
  List<Object> get props => [context];
}

class ClassEndDatePicker extends DatePickerEvent {
  final BuildContext context;
  const ClassEndDatePicker({required this.context});

  @override
  List<Object> get props => [context];
}
