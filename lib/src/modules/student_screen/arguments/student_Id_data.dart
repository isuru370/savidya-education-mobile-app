import 'package:equatable/equatable.dart';

class StudentIdData extends Equatable {
  final int studentId;
  final String cusStudentId;
  final String studentInitialName;

  const StudentIdData({
    required this.studentId,
    required this.cusStudentId,
    required this.studentInitialName,
  });

  @override
  List<Object?> get props => [studentId, studentInitialName, cusStudentId];
}
