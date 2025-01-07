part of 'get_student_bloc.dart';

sealed class GetStudentEvent extends Equatable {
  const GetStudentEvent();

  @override
  List<Object> get props => [];
}

class GetActiveStudentData extends GetStudentEvent {}

class GetUniqueStudentEvent extends GetStudentEvent {
  final String studentCustomId;
  const GetUniqueStudentEvent({required this.studentCustomId});

  @override
  List<Object> get props => [studentCustomId];
}

class GetUniqueStudentPercentageEvent extends GetStudentEvent {
  final int studentId;
  final int classCategoryHasStudentClassId;
  const GetUniqueStudentPercentageEvent({
    required this.studentId,
    required this.classCategoryHasStudentClassId,
  });

  @override
  List<Object> get props => [studentId, classCategoryHasStudentClassId];
}
