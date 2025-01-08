import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'days_event.dart';
part 'days_state.dart';

class DaysBloc extends Bloc<DaysEvent, DaysState> {
  DaysBloc() : super(const DaysInitial()) {
    on<LoadDays>((event, emit) {
      final daysList = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      emit(DaysLoaded(days: daysList));
    });
    on<SelectDay>((event, emit) {
      if (state is DaysLoaded) {
        final loadedState = state as DaysLoaded;
        emit(
            DaysLoaded(days: loadedState.days, selectedDay: event.selectedDay));
      }
    });
  }
}
