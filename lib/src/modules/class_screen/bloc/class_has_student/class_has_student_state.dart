part of 'class_has_student_bloc.dart';

sealed class ClassHasStudentState extends Equatable {
  const ClassHasStudentState();

  @override
  List<Object> get props => [];
}

final class ClassHasStudentInitial extends ClassHasStudentState {}

final class ClassHasStudentProcess extends ClassHasStudentState {}

final class ClassHasStudentFailure extends ClassHasStudentState {
  final String failureMessage;
  const ClassHasStudentFailure({
    required this.failureMessage,
  });
  @override
  List<Object> get props => [failureMessage];
}



final class StudentClassGetAllSuccess extends ClassHasStudentState {
  final List<StudentHasCategoryHasClassModelClass> classGetAllList;
  const StudentClassGetAllSuccess({required this.classGetAllList});

  @override
  List<Object> get props => [classGetAllList];
}

final class ClassGetActiveSuccess extends ClassHasStudentState {
  final List<StudentHasCategoryHasClassModelClass> classGetActiveList;
  const ClassGetActiveSuccess({required this.classGetActiveList});

  @override
  List<Object> get props => [classGetActiveList];
}

final class ClassGetInactiveSuccess extends ClassHasStudentState {
  final List<StudentHasCategoryHasClassModelClass> classGetInactiveList;
  const ClassGetInactiveSuccess({required this.classGetInactiveList});

  @override
  List<Object> get props => [classGetInactiveList];
}

final class GetClassHasStudentUniqueData extends ClassHasStudentState {
  final List<StudentHasCategoryHasClassModelClass> getUniqueStudent;
  final List<PercentageModelClass> getPercentage;
  const GetClassHasStudentUniqueData({required this.getUniqueStudent,required this.getPercentage});

    @override
  List<Object> get props => [getUniqueStudent,getPercentage];
}
