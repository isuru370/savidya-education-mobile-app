part of 'class_has_student_bloc.dart';

sealed class ClassHasStudentState extends Equatable {
  const ClassHasStudentState();
  
  @override
  List<Object> get props => [];
}

final class ClassHasStudentInitial extends ClassHasStudentState {}
