part of 'class_attendance_bloc.dart';

sealed class ClassAttendanceState extends Equatable {
  const ClassAttendanceState();

  @override
  List<Object> get props => [];
}

final class ClassAttendanceInitial extends ClassAttendanceState {}

final class ClassAttendanceProcess extends ClassAttendanceState {}

final class ClassAttendanceFailure extends ClassAttendanceState {
  final String failureMessage;
  const ClassAttendanceFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class ClassAttendanceInsertSuccess extends ClassAttendanceState {
  final String successMessage;
  const ClassAttendanceInsertSuccess({
    required this.successMessage,
  });

  @override
  List<Object> get props => [successMessage];
}

final class GetClassAttendanceSuccess extends ClassAttendanceState {
  final List<ClassAttendanceModelClass> classAttendanceList;
  const GetClassAttendanceSuccess({
    required this.classAttendanceList,
  });

  @override
  List<Object> get props => [classAttendanceList];
}
final class GetClassAttendanceListSuccess extends ClassAttendanceState {
  final List<ClassAttendanceListModel> classAttendanceList;
  const GetClassAttendanceListSuccess({
    required this.classAttendanceList,
  });

  @override
  List<Object> get props => [classAttendanceList];
}

final class ClassAttendanceListSuccess extends ClassAttendanceState {
  final String classAttendanceListSuccess;
  const ClassAttendanceListSuccess({
    required this.classAttendanceListSuccess,
  });

  @override
  List<Object> get props => [classAttendanceListSuccess];
}