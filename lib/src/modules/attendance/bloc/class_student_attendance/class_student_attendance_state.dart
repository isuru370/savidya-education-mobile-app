part of 'class_student_attendance_bloc.dart';

sealed class ClassStudentAttendanceState extends Equatable {
  const ClassStudentAttendanceState();

  @override
  List<Object> get props => [];
}

final class ClassStudentAttendanceInitial extends ClassStudentAttendanceState {}

final class ClassStudentAttendanceProcess extends ClassStudentAttendanceState {}

final class ClassStudentAttendanceFailure extends ClassStudentAttendanceState {
  final String errorMessage;
  const ClassStudentAttendanceFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class ClassStudentAttendanceSuccess extends ClassStudentAttendanceState {
  final List<ClassStudentAttendanceMode> classStudentAttendanceList;
  const ClassStudentAttendanceSuccess({required this.classStudentAttendanceList});

  @override
  List<Object> get props => [classStudentAttendanceList];
}
