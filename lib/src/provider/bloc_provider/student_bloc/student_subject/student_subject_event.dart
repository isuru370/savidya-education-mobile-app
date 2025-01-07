part of 'student_subject_bloc.dart';

sealed class StudentSubjectEvent extends Equatable {
  const StudentSubjectEvent();

  @override
  List<Object> get props => [];
}


class GetStudentSubject extends StudentSubjectEvent {}

class SetStudentSubject extends StudentSubjectEvent {
  final Subject subjectList;
  const SetStudentSubject({required this.subjectList});
}

class UpdateStudentSubject extends StudentSubjectEvent {
  final Subject subject;
  const UpdateStudentSubject({required this.subject});
}
