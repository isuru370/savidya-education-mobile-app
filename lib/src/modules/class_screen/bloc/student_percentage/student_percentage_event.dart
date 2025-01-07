part of 'student_percentage_bloc.dart';

sealed class StudentPercentageEvent extends Equatable {
  const StudentPercentageEvent();

  @override
  List<Object> get props => [];
}

final class GetStudentPercentageEvent extends StudentPercentageEvent {
  final int studentId;
  final int classHasCatId;
  const GetStudentPercentageEvent(
      {required this.studentId, required this.classHasCatId});

  @override
  List<Object> get props => [studentId, classHasCatId];
}
