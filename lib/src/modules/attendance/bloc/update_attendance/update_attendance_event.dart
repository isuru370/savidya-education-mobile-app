part of 'update_attendance_bloc.dart';

sealed class UpdateAttendanceEvent extends Equatable {
  const UpdateAttendanceEvent();

  @override
  List<Object> get props => [];
}

final class UpdateAttendance extends UpdateAttendanceEvent {
  final StudentAttendanceModelClass studentAttendanceModelClass;
  const UpdateAttendance({required this.studentAttendanceModelClass});

   @override
  List<Object> get props => [studentAttendanceModelClass];
}
