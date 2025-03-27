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
class ClassAttendanceListEvent extends ClassAttendanceEvent {
  final int classHasCatId;
  final String dayOfWeek;
  const ClassAttendanceListEvent({required this.classHasCatId,required this.dayOfWeek});

  @override
  List<Object> get props => [classHasCatId,dayOfWeek];
}
class ClassAttendanceUpdateEvent extends ClassAttendanceEvent {
  final int classAttendanceId; 
  const ClassAttendanceUpdateEvent({required this.classAttendanceId});

  @override
  List<Object> get props => [classAttendanceId];
}