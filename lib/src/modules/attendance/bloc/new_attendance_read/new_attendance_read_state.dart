part of 'new_attendance_read_bloc.dart';

@immutable
sealed class NewAttendanceReadState extends Equatable {
  const NewAttendanceReadState();
  @override
  List<Object?> get props => [];
}

final class NewAttendanceReadInitial extends NewAttendanceReadState {}

final class NewAttendanceReadProcess extends NewAttendanceReadState {}

final class NewAttendanceReadFailure extends NewAttendanceReadState {
  final String failureMSG;
  const NewAttendanceReadFailure({required this.failureMSG});

  @override
  List<Object?> get props => [failureMSG];
}

final class NewAttendanceReadSuccess extends NewAttendanceReadState {
    final List<NewAttendanceReadModel> newAttendanceReadModel;
  const NewAttendanceReadSuccess({required this.newAttendanceReadModel});

  @override
  List<Object?> get props => [newAttendanceReadModel];
}
