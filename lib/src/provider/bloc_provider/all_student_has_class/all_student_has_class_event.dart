part of 'all_student_has_class_bloc.dart';

sealed class AllStudentHasClassEvent extends Equatable {
  const AllStudentHasClassEvent();

  @override
  List<Object> get props => [];
}

final class GetAllStudentHasClass extends AllStudentHasClassEvent{}