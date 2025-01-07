part of 'all_student_has_class_bloc.dart';

sealed class AllStudentHasClassState extends Equatable {
  const AllStudentHasClassState();

  @override
  List<Object> get props => [];
}

final class AllStudentHasClassInitial extends AllStudentHasClassState {}

final class AllStudentHasClassProcess extends AllStudentHasClassState {}

final class AllStudentHasClassFailure extends AllStudentHasClassState {
  final String errorMessage;
  const AllStudentHasClassFailure({required this.errorMessage});

   @override
  List<Object> get props => [errorMessage];
}

final class AllStudentHasClassSuccess extends AllStudentHasClassState {
   final List<StudentHasCategoryHasClassModelClass> studentHasClassList;
  const AllStudentHasClassSuccess({required this.studentHasClassList});

   @override
  List<Object> get props => [studentHasClassList];
}
