part of 'attendance_count_bloc.dart';

sealed class AttendanceCountEvent extends Equatable {
  const AttendanceCountEvent();

  @override
  List<Object> get props => [];
}

final class CountAttendanceEvent extends AttendanceCountEvent {
  final String date;
  final int studentStudentClassId;
  final int studentId;
  const CountAttendanceEvent({
    required this.date,
    required this.studentStudentClassId,
    required this.studentId,
  });

  @override
  List<Object> get props => [
        date,
        studentStudentClassId,
        studentId,
      ];
}
