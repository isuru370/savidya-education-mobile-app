part of 'new_attendance_read_bloc.dart';

@immutable
sealed class NewAttendanceReadEvent extends Equatable {
  const NewAttendanceReadEvent();
  @override
  List<Object?> get props => [];
}

final class GetAttendanceReadDateEvent extends NewAttendanceReadEvent {
  final String studentCustomId;
  const GetAttendanceReadDateEvent({required this.studentCustomId});

  @override
  List<Object?> get props => [studentCustomId];
}
