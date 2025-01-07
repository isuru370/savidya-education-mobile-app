part of 'unique_attendance_bloc.dart';

sealed class UniqueAttendanceEvent extends Equatable {
  const UniqueAttendanceEvent();

  @override
  List<Object> get props => [];
}

final class GetUniqueStudentAttendanceEvent extends UniqueAttendanceEvent {
  final int classCategoryHasStudentClassId;
  final int studentId;
  const GetUniqueStudentAttendanceEvent({
    required this.classCategoryHasStudentClassId,
    required this.studentId,
  });

  @override
  List<Object> get props => [
        classCategoryHasStudentClassId,
        studentId,
      ];
}
