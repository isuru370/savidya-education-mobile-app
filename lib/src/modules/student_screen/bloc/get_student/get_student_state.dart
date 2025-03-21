part of 'get_student_bloc.dart';

sealed class GetStudentState extends Equatable {
  const GetStudentState();

  @override
  List<Object> get props => [];
}

class GetStudentDataProcess extends GetStudentState {}

class GetStudentDataFailure extends GetStudentState {
  final String failureMessage;
  const GetStudentDataFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class GetStudentInitial extends GetStudentState {}

class GetAllActiveStudentSuccess extends GetStudentState {
  final List<StudentModelClass> activeStudentList;
  const GetAllActiveStudentSuccess({required this.activeStudentList});

  @override
  List<Object> get props => [activeStudentList];
}

class GetUniqueStudentSuccess extends GetStudentState {
  final List<StudentModelClass> getUniqueStudentList;
  const GetUniqueStudentSuccess({required this.getUniqueStudentList});

  @override
  List<Object> get props => [getUniqueStudentList];
}

class GetStudentPercentageSuccess extends GetStudentState {
  final int presentCount;
  final int absentCount;
  final double percentage;
  final double attendancePercentage;
  const GetStudentPercentageSuccess({
    required this.presentCount,
    required this.absentCount,
    required this.percentage,
    required this.attendancePercentage,
  });

  @override
  List<Object> get props =>
      [presentCount, absentCount, percentage, attendancePercentage];
}

final class UpdateStudentGradeSuccess extends GetStudentState {
  final String message;
  const UpdateStudentGradeSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
