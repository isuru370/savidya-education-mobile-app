part of 'update_attendance_bloc.dart';

sealed class UpdateAttendanceEvent extends Equatable {
  const UpdateAttendanceEvent();

  @override
  List<Object> get props => [];
}

final class UpdateAttendance extends UpdateAttendanceEvent {
  final int classAttendanceId;
  final String atDate;
  final int studentId;
  final int studentHasClassId;
  const UpdateAttendance(
      {required this.classAttendanceId,
      required this.atDate,
      required this.studentId,
      required this.studentHasClassId});

  @override
  List<Object> get props => [
        classAttendanceId,
        atDate,
        studentId,
        studentHasClassId,
      ];
}
