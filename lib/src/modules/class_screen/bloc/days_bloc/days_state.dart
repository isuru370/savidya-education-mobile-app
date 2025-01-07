part of 'days_bloc.dart';

sealed class DaysState extends Equatable {
  const DaysState();

  @override
  List<Object> get props => [];
}

final class DaysInitial extends DaysState {
  const DaysInitial();

  @override
  List<Object> get props => [];
}

class DaysLoaded extends DaysState {
  final List<String> days;
  final String? selectedDay;

  const DaysLoaded({required this.days, this.selectedDay});

  @override
  List<Object> get props => [days, selectedDay ?? ''];
}
