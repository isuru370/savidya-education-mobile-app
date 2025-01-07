part of 'today_classes_bloc.dart';

@immutable
sealed class TodayClassesEvent extends Equatable {
  const TodayClassesEvent();

  @override
  List<Object?> get props => [];
}

final class GetTodayClassEvent extends TodayClassesEvent {
  final String selectDate;
  const GetTodayClassEvent({required this.selectDate});

  @override
  List<Object?> get props => [selectDate];
}
