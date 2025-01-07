part of 'days_bloc.dart';

sealed class DaysEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDays extends DaysEvent {}

class SelectDay extends DaysEvent {
  final String selectedDay;

  SelectDay({required this.selectedDay});

  @override
  List<Object> get props => [selectedDay];
}
