part of 'experience_year_bloc.dart';

sealed class ExperienceYearEvent extends Equatable {
  const ExperienceYearEvent();

  @override
  List<Object> get props => [];
}

class LoadExperienceYear extends ExperienceYearEvent {}

class SelectExperienceYear extends ExperienceYearEvent {
  final String selectedExperienceYear;

  const SelectExperienceYear({required this.selectedExperienceYear});

  @override
  List<Object> get props => [selectedExperienceYear];
}
