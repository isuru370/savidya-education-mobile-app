part of 'update_attendance_bloc.dart';

sealed class UpdateAttendanceState extends Equatable {
  const UpdateAttendanceState();

  @override
  List<Object> get props => [];
}

final class UpdateAttendanceInitial extends UpdateAttendanceState {}

final class UpdateAttendanceProcess extends UpdateAttendanceState {}

final class UpdateAttendanceFailure extends UpdateAttendanceState {
  final String errorMessage;
  const UpdateAttendanceFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class UpdateAttendanceSuccess extends UpdateAttendanceState {
  final String successMessage;
  const UpdateAttendanceSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}
