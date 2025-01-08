import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'experience_year_event.dart';
part 'experience_year_state.dart';

class ExperienceYearBloc
    extends Bloc<ExperienceYearEvent, ExperienceYearState> {
  ExperienceYearBloc() : super(ExperienceYearInitial()) {
    on<LoadExperienceYear>((event, emit) {
      final exYearList = [
        'Less than a year',
        'One year',
        'Two years',
        'Less than two years',
        'Three years',
        'Less than three years',
        'Four years',
        'Less than four years old',
        'Five years',
        'More than five years'
      ];
      emit(ExperienceYearLoaded(experienceYearList: exYearList));
    });
    on<SelectExperienceYear>((event, emit) {
      if (state is ExperienceYearLoaded) {
        final loadedState = state as ExperienceYearLoaded;
        emit(ExperienceYearLoaded(
            experienceYearList: loadedState.experienceYearList,
            selectedExperienceYear: event.selectedExperienceYear));
      }
    });
  }
}
