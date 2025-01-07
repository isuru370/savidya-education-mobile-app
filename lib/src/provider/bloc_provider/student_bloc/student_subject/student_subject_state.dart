part of 'student_subject_bloc.dart';

sealed class StudentSubjectState extends Equatable {
  const StudentSubjectState();
  
  @override
  List<Object> get props => [];
}

final class StudentSubjectInitial extends StudentSubjectState {}

final class GetStudentSubjectSuccess extends StudentSubjectState {
  final List<Subject> getSubjectList;
  const GetStudentSubjectSuccess({required this.getSubjectList});

  @override
  List<Object> get props => [getSubjectList];
}

final class GetStudentSubjectFailure extends StudentSubjectState {
  final String message;
  const GetStudentSubjectFailure({required this.message});

  @override
  List<Object> get props => [message];
}

