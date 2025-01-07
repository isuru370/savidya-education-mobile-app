part of 'attendance_count_bloc.dart';

sealed class AttendanceCountState extends Equatable {
  const AttendanceCountState();

  @override
  List<Object> get props => [];
}

final class AttendanceCountInitial extends AttendanceCountState {}

final class AttendanceCountProcess extends AttendanceCountState {}

final class AttendanceCountFailure extends AttendanceCountState {
  final String failureMessage;
  const AttendanceCountFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class AttendanceCountSuccess extends AttendanceCountState {
  final int attendanceCount;
  const AttendanceCountSuccess({required this.attendanceCount});

  @override
  List<Object> get props => [attendanceCount];
}
