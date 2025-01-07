part of 'student_percentage_bloc.dart';

sealed class StudentPercentageState extends Equatable {
  const StudentPercentageState();

  @override
  List<Object> get props => [];
}

final class StudentPercentageInitial extends StudentPercentageState {}

final class StudentPercentageLoading extends StudentPercentageState {}

final class StudentPercentageFailure extends StudentPercentageState {
  final String message;
  const StudentPercentageFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class StudentPercentageSuccess extends StudentPercentageState {
  final List<PercentageModelClass> getPercentage;
  const StudentPercentageSuccess({required this.getPercentage});

  @override
  List<Object> get props => [getPercentage];
}
