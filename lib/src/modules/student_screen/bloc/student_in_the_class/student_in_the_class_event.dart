part of 'student_in_the_class_bloc.dart';

@immutable
sealed class StudentInTheClassEvent extends Equatable {
  const StudentInTheClassEvent();
  @override
  List<Object?> get props => [];
}

final class GetStudentInTheClassEvent extends StudentInTheClassEvent {
  final int studentClassId;
  final int studentHasCatId;

  const GetStudentInTheClassEvent(
      {required this.studentClassId, required this.studentHasCatId});

  @override
  List<Object?> get props => [studentClassId, studentHasCatId];
}

final class GetStudentAllClassEvent extends StudentInTheClassEvent {
  final int studentId;

  const GetStudentAllClassEvent({required this.studentId});

  @override
  List<Object?> get props => [studentId];
}
