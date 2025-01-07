part of 'time_cubit.dart';

sealed class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

final class TimeInitial extends TimeState {
  final int hours;
  final int minutes;
  final String amPm;

  const TimeInitial({required this.hours, required this.minutes, required this.amPm});

  @override
  List<Object> get props => [hours, minutes, amPm];
}
