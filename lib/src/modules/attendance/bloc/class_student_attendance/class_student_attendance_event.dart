part of 'class_student_attendance_bloc.dart';

sealed class ClassStudentAttendanceEvent extends Equatable {
  const ClassStudentAttendanceEvent();

  @override
  List<Object> get props => [];
}

final class GetClassStudentAttendance extends ClassStudentAttendanceEvent {
  final ClassStudentAttendanceMode classStudentAttendanceMode;
  const GetClassStudentAttendance({required this.classStudentAttendanceMode});

  @override
  List<Object> get props => [classStudentAttendanceMode];
}
