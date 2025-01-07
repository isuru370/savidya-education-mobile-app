part of 'teacher_bloc.dart';

sealed class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object> get props => [];
}

class GetTeacherData extends TeacherEvent {}

class InsertTeacherData extends TeacherEvent {
  final TeacherModelClass teacherModelClass;
  const InsertTeacherData({required this.teacherModelClass});

  @override
  List<Object> get props => [teacherModelClass];
}

class UpdateTeacherData extends TeacherEvent {
  final TeacherModelClass teacherModelClass;
  final int teacherId;
  const UpdateTeacherData(
      {required this.teacherModelClass, required this.teacherId});

  @override
  List<Object> get props => [
        teacherModelClass,
        teacherId,
      ];
}
