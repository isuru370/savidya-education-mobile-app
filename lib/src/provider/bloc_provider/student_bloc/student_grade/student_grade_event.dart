part of 'student_grade_bloc.dart';

sealed class StudentGradeEvent extends Equatable {
  const StudentGradeEvent();

  @override
  List<Object> get props => [];
}

class GetStudentGrade extends StudentGradeEvent {}

class SetStudentGrade extends StudentGradeEvent {
  final Grade gradeList;
  const SetStudentGrade({required this.gradeList});

  @override
  List<Object> get props => [gradeList];
}

class UpdateStudentGrade extends StudentGradeEvent {
  final Grade grade;
  const UpdateStudentGrade({required this.grade});

  @override
  List<Object> get props => [grade];
}
