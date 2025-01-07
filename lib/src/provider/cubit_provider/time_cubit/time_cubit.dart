import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(const TimeInitial(hours: 0, minutes: 0, amPm: 'AM'));

  void updateHours(int hours) {
    final currentState = state as TimeInitial;
    emit(TimeInitial(
      hours: hours,
      minutes: currentState.minutes,
      amPm: currentState.amPm,
    ));
  }

  void updateMinutes(int minutes) {
    final currentState = state as TimeInitial;
    emit(TimeInitial(
      hours: currentState.hours,
      minutes: minutes,
      amPm: currentState.amPm,
    ));
  }

  void updateAmPm(String amPm) {
    final currentState = state as TimeInitial;
    emit(TimeInitial(
      hours: currentState.hours,
      minutes: currentState.minutes,
      amPm: amPm,
    ));
  }
}
