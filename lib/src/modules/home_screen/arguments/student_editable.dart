import 'package:aloka_mobile_app/src/models/student/student.dart';
import 'package:equatable/equatable.dart';

class StudentEditable extends Equatable {
  final StudentModelClass? studentModelClass;
  final bool editable;

  const StudentEditable({
    this.studentModelClass,
    required this.editable
  });
  @override
  List<Object?> get props => [studentModelClass,editable];
}

class ActiveStudentViewEditable extends Equatable {
  final bool editable;

  const ActiveStudentViewEditable({
    required this.editable
  });
  @override
  List<Object?> get props => [editable];
}
