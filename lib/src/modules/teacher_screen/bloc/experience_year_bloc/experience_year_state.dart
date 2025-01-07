part of 'experience_year_bloc.dart';

sealed class ExperienceYearState extends Equatable {
  const ExperienceYearState();

  @override
  List<Object> get props => [];
}

final class ExperienceYearInitial extends ExperienceYearState {}

class ExperienceYearLoaded extends ExperienceYearState {
  final List<String> experienceYearList;
  final String? selectedExperienceYear;

  const ExperienceYearLoaded(
      {required this.experienceYearList, this.selectedExperienceYear});

  @override
  List<Object> get props => [experienceYearList, selectedExperienceYear ?? ''];
}
