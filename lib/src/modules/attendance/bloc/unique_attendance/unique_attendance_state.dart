part of 'unique_attendance_bloc.dart';

sealed class UniqueAttendanceState extends Equatable {
  const UniqueAttendanceState();

  @override
  List<Object> get props => [];
}

final class UniqueAttendanceInitial extends UniqueAttendanceState {}

final class UniqueAttendanceProcess extends UniqueAttendanceState {}

final class UniqueAttendanceFailure extends UniqueAttendanceState {
  final String failureMessage;
  const UniqueAttendanceFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class UniqueAttendanceSuccess extends UniqueAttendanceState {
  final List<GetStudentAttendanceModelClass> modelAttendance;
  const UniqueAttendanceSuccess({required this.modelAttendance});

  @override
  List<Object> get props => [modelAttendance];
}
