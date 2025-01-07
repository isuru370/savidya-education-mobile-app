part of 'manage_student_bloc.dart';

sealed class ManageStudentEvent extends Equatable {
  const ManageStudentEvent();

  @override
  List<Object?> get props => [];
}

class InsertManageStudentEvent extends ManageStudentEvent {
  final StudentModelClass studentModelClass;
  final File? studentImagePath;

  const InsertManageStudentEvent({
    required this.studentModelClass,
    required this.studentImagePath,
  });
  @override
  List<Object?> get props => [studentModelClass, studentImagePath];
}

class UpdateManageStudentEvent extends ManageStudentEvent {
  final StudentModelClass studentModelClass;
  final File? studentImagePath;
  final int? studentId;

  const UpdateManageStudentEvent({
    required this.studentModelClass,
    required this.studentImagePath,
    required this.studentId,
  });
  @override
  List<Object?> get props => [studentModelClass, studentImagePath, studentId];
}

class StudentAddClassEvent extends ManageStudentEvent {
  final StudentModelClass studentModelClass;
  const StudentAddClassEvent({required this.studentModelClass});

  @override
  List<Object?> get props => [studentModelClass];
}

