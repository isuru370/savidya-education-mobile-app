part of 'student_grade_bloc.dart';

sealed class StudentGradeState extends Equatable {
  const StudentGradeState();

  @override
  List<Object> get props => [];
}

final class StudentGradeInitial extends StudentGradeState {}

final class GetStudentGradeSuccess extends StudentGradeState {
  final List<Grade> getGradeList;
  const GetStudentGradeSuccess({required this.getGradeList});

  @override
  List<Object> get props => [getGradeList];
}

final class GetStudentGradeFailure extends StudentGradeState {
  final String message;
  const GetStudentGradeFailure({required this.message});

  @override
  List<Object> get props => [message];
}
