part of 'class_attendance_bloc.dart';

sealed class ClassAttendanceEvent extends Equatable {
  const ClassAttendanceEvent();

  @override
  List<Object> get props => [];
}

class ClassAttendanceMarkEvent extends ClassAttendanceEvent {
  final ClassAttendanceModelClass attendanceModelClass;
  const ClassAttendanceMarkEvent({required this.attendanceModelClass});

  @override
  List<Object> get props => [attendanceModelClass];
}

class GetClassAttendanceEvent extends ClassAttendanceEvent {
  final int classCatId;
  const GetClassAttendanceEvent({required this.classCatId});

  @override
  List<Object> get props => [classCatId];
}

class ClassReScheduleEvent extends ClassAttendanceEvent {
  final ClassAttendanceModelClass attendanceModelClass;
  const ClassReScheduleEvent({required this.attendanceModelClass});

  @override
  List<Object> get props => [attendanceModelClass];
}
