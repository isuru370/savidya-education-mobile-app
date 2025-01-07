part of 'manage_student_bloc.dart';

sealed class ManageStudentState extends Equatable {
  const ManageStudentState();

  @override
  List<Object?> get props => [];
}

final class StudentInitial extends ManageStudentState {}

class StudentDataProcess extends ManageStudentState {}

class StudentDataFailure extends ManageStudentState {
  final String failureMessage;
  const StudentDataFailure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class StudentDataProcessSuccess extends ManageStudentState {
  final String successMessage;
  final String studentId;
  final String studentCusId;
  const StudentDataProcessSuccess({
    required this.studentId,
    required this.studentCusId,
    required this.successMessage,
  });

  @override
  List<Object?> get props => [successMessage, studentId, studentCusId];
}

class StudentUpDataProcessSuccess extends ManageStudentState {
  final String successMessage;
  const StudentUpDataProcessSuccess({
    required this.successMessage,
  });

  @override
  List<Object?> get props => [successMessage];
}

class StudentClassAddSuccess extends ManageStudentState {
  final String successMessage;
  const StudentClassAddSuccess({
    required this.successMessage,
  });
}
