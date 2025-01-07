part of 'chenge_student_class_bloc.dart';

sealed class ChangeStudentClassState extends Equatable {
  const ChangeStudentClassState();

  @override
  List<Object> get props => [];
}

final class ChangeStudentClassInitial extends ChangeStudentClassState {}

final class ChangeStudentClassProcess extends ChangeStudentClassState {}

final class ChangeStudentClassFailure extends ChangeStudentClassState {
  final String failureMessage;
  const ChangeStudentClassFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

final class ChangeStudentClassSuccess extends ChangeStudentClassState {
  final String successMessage;
  const ChangeStudentClassSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

final class DeleteStudentClassSuccess extends ChangeStudentClassState {
  final String deleteMessage;
  const DeleteStudentClassSuccess({required this.deleteMessage});

  @override
  List<Object> get props => [deleteMessage];
}

final class DeleteStudentClassFailure extends ChangeStudentClassState {
  final String deleteFailureMessage;
  const DeleteStudentClassFailure({required this.deleteFailureMessage});

  @override
  List<Object> get props => [deleteFailureMessage];
}

