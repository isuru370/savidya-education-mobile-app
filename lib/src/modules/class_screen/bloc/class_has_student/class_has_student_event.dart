part of 'class_has_student_bloc.dart';

sealed class ClassHasStudentEvent extends Equatable {
  const ClassHasStudentEvent();

  @override
  List<Object> get props => [];
}

final class ClassHasStudentActiveClass extends ClassHasStudentEvent {}

final class ClassHasStudentInactiveClass extends ClassHasStudentEvent {}

final class GetClassHasStudentUniqueClassEvent extends ClassHasStudentEvent {
  final int studentId;
  const GetClassHasStudentUniqueClassEvent({required this.studentId});

  @override
  List<Object> get props => [studentId];
}
